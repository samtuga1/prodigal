class SpeechState {
  final bool listeningToSpeech;
  final String speech2TextString;

  SpeechState({
    this.listeningToSpeech = false,
    this.speech2TextString = '',
  });

  SpeechState copyWith({
    bool? listeningToSpeech,
    String? speech2TextString,
  }) {
    return SpeechState(
      listeningToSpeech: listeningToSpeech ?? this.listeningToSpeech,
      speech2TextString: speech2TextString ?? this.speech2TextString,
    );
  }
}
