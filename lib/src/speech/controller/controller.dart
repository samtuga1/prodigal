import 'dart:ui';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:prodigal/utils/functions.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:prodigal/app.dart';
import 'package:prodigal/services/voice_api.dart';
import 'package:prodigal/src/speech/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'controller.g.dart';

@riverpod
class SpeechController extends _$SpeechController {
  @override
  SpeechState build() {
    textEditingController = TextEditingController();
    return SpeechState();
  }

  ValueNotifier<double> elapsed = ValueNotifier(0);
  SpeechToText speech = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  late final Ticker ticker;
  VoiceApi voiceApi = VoiceApi();
  ValueNotifier<List<EqualizerData>> data = ValueNotifier([]);
  ValueNotifier<List<EqualizerData>> data2Animation = ValueNotifier([]);
  ValueNotifier<double> shockwaveAnimationStart = ValueNotifier(-10);
  late TextEditingController textEditingController;

  void initializeSpeech() async {
    final context = navigatorKey!.currentContext!;

    bool available = await speech.initialize(
      debugLogging: true,
      onStatus: (s) {
        print(s);
      },
      onError: (e) {
        print(e);
      },
    );
    if (!available) {
      if (context.mounted) {
        showToast(context, message: 'Speech recognition has been denied');
      }
      return;
    }

    // Start the ticker for animations
    ticker = Ticker((elapsed) {
      this.elapsed.value = (elapsed.inMilliseconds / 1000);

      if (data2Animation.value.isEmpty) {
        data2Animation = data;
      } else {
        // Smoothly interpolate data values for animation
        for (int i = 0; i < data.value.length; i++) {
          data2Animation.value[i] = (
            spectrum: data2Animation.value[i].spectrum,
            value: lerpDouble(data2Animation.value[i].value, data.value[i].value, 0.1)!,
          );
        }
      }
    })
      ..start();
  }

  // Starts listening to speech and capturing audio frequencies
  void listenToSpeech() async {
    shockwaveAnimationStart.value = elapsed.value;

    await Feedback.forLongPress(navigatorKey!.currentState!.context);

    // Start recording and processing audio
    await voiceApi.startRecording((data) {
      this.data.value = data;
    });

    speech.listen(
      onResult: (result) {
        // update the result of the speech
        state = state.copyWith(speech2TextString: result.recognizedWords);
      },
    );

    state = state.copyWith(listeningToSpeech: true);
  }

  void stopListening() async {
    state = state.copyWith(listeningToSpeech: false);
    await Future.wait([voiceApi.stopRecording(), speech.stop()]);
  }

  Future<void> speak() async {
    await flutterTts.speak(textEditingController.text.trim());
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
  }

  void disposeTicker() {
    ticker.dispose();
    speech.cancel();
  }
}

typedef EqualizerData = ({FrequencySpectrum spectrum, double value});
