import 'dart:ui';

class User {
  final int id;
  final bool muted;
  final Color? localColor;
  final String username;
  final bool speaking;

  User({
    required this.id,
    required this.username,
    this.muted = false,
    this.localColor,
    this.speaking = false,
  });

  User copyWith({bool? muted, Color? localColor, bool? speaking}) {
    return User(
      id: id,
      username: username,
      muted: muted ?? this.muted,
      localColor: localColor ?? this.localColor,
      speaking: speaking ?? this.speaking,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}
