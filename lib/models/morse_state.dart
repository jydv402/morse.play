class MorseConverterState {
  final String rawtext;
  final String morseCode;
  final bool isPlaying;
  final int currentRawIndex;
  final int currentMorseIndex;

  const MorseConverterState({
    this.rawtext = '',
    this.morseCode = '',
    this.isPlaying = false,
    this.currentRawIndex = -1,
    this.currentMorseIndex = -1,
  });

  // CopyWith method
  MorseConverterState copyWith({
    String? rawtext,
    String? morseCode,
    bool? isPlaying,
    int? currentRawIndex,
    int? currentMorseIndex,
  }) {
    return MorseConverterState(
      // Stores the raw input text
      rawtext: rawtext ?? this.rawtext,
      // Stores the converted morse code
      morseCode: morseCode ?? this.morseCode,
      // Stores the bool value for checking if the audio is playing or not
      isPlaying: isPlaying ?? this.isPlaying,
      // Current character being played
      currentRawIndex: currentRawIndex ?? this.currentRawIndex,
      // Current morse character/symbol being played
      currentMorseIndex: currentMorseIndex ?? this.currentMorseIndex,
    );
  }
}
