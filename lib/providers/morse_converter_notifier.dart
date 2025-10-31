import 'package:morse_web_play/barrel.dart';

class MorseConverterNotifier extends Notifier<MorseConverterState> {
  @override
  MorseConverterState build() {
    return const MorseConverterState();
  }

  //Logic function
  // Calls the textToMorse function from the MorseService and updates the state with the new result
  void textToMorse(String text) {
    // Define a MorseService instance
    final morseService = ref.read(morseServiceProvider);

    // Call the textToMorse method found in MorseService
    final morseCode = morseService.textToMorse(text);

    // Update state
    state = state.copyWith(morseCode: morseCode, rawtext: text);
  }
}

final morseConverterProvider =
    NotifierProvider<MorseConverterNotifier, MorseConverterState>(() {
      return MorseConverterNotifier();
    });
