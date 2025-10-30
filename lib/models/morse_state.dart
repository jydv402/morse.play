class MorseConverterState {
  final String rawtext;
  final String morseCode;

  const MorseConverterState({this.rawtext = '', this.morseCode = ''});

  // CopyWith method
  MorseConverterState copyWith({String? rawtext, String? morseCode}) {
    return MorseConverterState(
      rawtext: rawtext ?? this.rawtext,
      morseCode: morseCode ?? this.morseCode,
    );
  }
}
