import 'package:prodigal/models/user.dart';

class VoiceChatState {
  final bool initializing;
  final bool? initializeSuccess;
  final String? initializeError;

  final List<User> users;
  final bool muted;

  VoiceChatState({
    this.initializing = false,
    this.initializeSuccess,
    this.initializeError,
    this.users = const [],
    this.muted = false,
  });

  VoiceChatState copyWith({
    bool? initializing,
    bool? initializeSuccess,
    String? initializeError,
    List<User>? users,
    bool? muted,
  }) {
    return VoiceChatState(
      initializing: initializing ?? this.initializing,
      initializeSuccess: initializeSuccess,
      initializeError: initializeError,
      users: users ?? this.users,
      muted: muted ?? this.muted,
    );
  }
}
