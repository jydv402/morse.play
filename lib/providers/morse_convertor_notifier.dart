import 'package:morse_web_play/barrel.dart';

class MorseConvertorNotifier extends Notifier<MorseConverterState> {
  @override
  MorseConverterState build() {
    return const MorseConverterState();
  }

  //Logic function
  void textToMorse(String text) {
    // Define a MorseService instance
    final morseService = ref.read(morseServiceProvider);

    // Call the textToMorse method
    final morseCode = morseService.textToMorse(text);

    // Update state
    state = state.copyWith(morseCode: morseCode, rawtext: text);
  }
}

final morseConverterProvider =
    NotifierProvider<MorseConvertorNotifier, MorseConverterState>(() {
      return MorseConvertorNotifier();
    });
