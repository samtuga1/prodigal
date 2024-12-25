import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prodigal/config/global_configuration.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/models/user.dart';
import 'package:prodigal/repositories/user.repo.dart';
import 'package:prodigal/services/auth.service.dart';
import 'package:prodigal/src/voice_chat/state.dart';
import 'package:prodigal/utils/extensions.dart';
import 'package:prodigal/utils/functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@riverpod
class VoiceChatController extends _$VoiceChatController {
  @override
  VoiceChatState build() {
    initializeEngine();
    ref.onDispose(_dispose);
    return VoiceChatState();
  }

  final RtcEngine engine = createAgoraRtcEngine();
  final TextEditingController channelCtrl = TextEditingController();

  void initializeEngine() async {
    await Future.value(1); // wait for the state to be available
    state = state.copyWith(initializing: true);
    await [Permission.microphone].request();

    await engine.initialize(
      RtcEngineContext(
        appId: GlobalConfiguration.instance.appConfig['agora_app_id'],
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    // await engine.enableAudio();

    // await engine.enableLocalAudio(true);

    await engine.enableAudioVolumeIndication(
      interval: 500, // Interval in milliseconds for the volume indication callback
      smooth: 3, // Smoothing factor for the volume indication data
      reportVad: true, // Whether to report the voice activity detection result
    );

    // register needed agora handlers
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onAudioVolumeIndication: _onAudioVolumeIndication,
        onJoinChannelSuccess: _onJoinChannelSuccess,
        onUserJoined: _onUserJoined,
        onUserOffline: _onUserOffline,
        onUserMuteAudio: _onUserMuteAudio,
        onLeaveChannel: _onLeaveChannel,
      ),
    );

    // for bot purposes (to listen to the stream of audios)
    engine.registerAudioEncodedFrameObserver(
      config: const AudioEncodedFrameObserverConfig(),
      observer: AudioEncodedFrameObserver(
        onMixedAudioEncodedFrame: _onMixedAudioEncodedFrame,
      ),
    );
    state = state.copyWith(initializing: false);
  }

  void _onMixedAudioEncodedFrame(Uint8List frameBuffer, int length, EncodedAudioFrameInfo audioEncodedFrameInfo) {
    // setup a bot to listen to audio inputs from users
  }

  // this token is used to join/create channels
  Future<String> generateToken() async {
    // Token will be valid for 1 hour
    const expirationInSeconds = 3600;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;

    final user = await sl<AuthedUserRepository>().getUser();
    return RtcTokenBuilder.build(
      appId: GlobalConfiguration.instance.appConfig['agora_app_id'],
      appCertificate: GlobalConfiguration.instance.appConfig['agora_cert'],
      channelName: channelCtrl.text.trim(),
      uid: user!.id.toString(),
      role: RtcRole.publisher,
      expireTimestamp: expireTimestamp,
    );
  }

  void _onLeaveChannel(RtcConnection connection, RtcStats stats) {
    state = state.copyWith(users: state.users.where((user) => user.id != connection.localUid).toList());
  }

  void _onAudioVolumeIndication(
    RtcConnection connection,
    List<AudioVolumeInfo> speakers,
    int speakerVolume,
    int totalVolume,
  ) {
    // Filter speakers with non-zero volume
    final activeSpeakers = speakers
        .where(
          (speaker) => speaker.volume! > 5,
        )
        .map((speaker) => speaker.uid)
        .toSet()
        .toList();

    // Update the state with active speakers
    state = state.copyWith(
      users: state.users.map((user) {
        final isSpeaking = activeSpeakers.contains(user.id);
        // print(isSpeaking);
        return user.copyWith(speaking: isSpeaking);
      }).toList(),
    );
  }

  Future<void> leaveChannel() async {
    await engine.leaveChannel();
    ref.invalidateSelf();
  }

  Future<void> toggleMicrophone() async {
    final localUser = await sl<AuthedUserRepository>().getUser();

    if (localUser == null) return;
    final mute = !state.muted;
    await engine.muteLocalAudioStream(mute);

    // hanlde for local user
    state = state.copyWith(
        muted: mute,
        users: state.users.map((user) {
          if (user.id == localUser.id) {
            return user.copyWith(muted: mute);
          }
          return user;
        }).toList());
  }

  void _onUserMuteAudio(RtcConnection connection, int remoteUid, bool muted) {
    state = state.copyWith(
      users: state.users.map((user) {
        if (user.id == remoteUid) {
          return user.copyWith(muted: muted);
        }
        return user;
      }).toList(),
    );
  }

  void _onJoinChannelSuccess(RtcConnection connection, int elapsed) async {
    final localUser = await sl<AuthedUserRepository>().getUser();
    if (localUser == null) return;

    final userExists = state.users.firstWhereOrNull((user) => user.id == localUser.id) != null;
    if (userExists) return;
    state = state.copyWith(users: [
      ...state.users,
      User(
        id: connection.localUid!,
        muted: false,
        localColor: randomColor,
        username: localUser.username,
      ),
    ]);
  }

  void _onUserJoined(RtcConnection connection, int remoteUid, int elapsed) async {
    final userExists = state.users.firstWhereOrNull((user) => user.id == remoteUid) != null;
    if (userExists) return;

    final response = await AuthService.getUser(remoteUid);

    response.fold(
      onSuccess: (user) {
        state = state.copyWith(users: [
          ...state.users,
          User(
            id: remoteUid,
            muted: false,
            localColor: randomColor,
            username: user.username,
          )
        ]);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }

  void _onUserOffline(RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
    state = state.copyWith(users: state.users.where((user) => user.id != remoteUid).toList());
  }

  Future<void> joinChannel() async {
    final user = await sl<AuthedUserRepository>().getUser();

    if (user == null) return;
    final token = await generateToken();
    await engine.joinChannel(
      token: token,
      channelId: channelCtrl.text.trim(),
      options: const ChannelMediaOptions(
        autoSubscribeAudio: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: user.id,
    );
  }

  void _dispose() async {
    await engine.release();
  }
}
