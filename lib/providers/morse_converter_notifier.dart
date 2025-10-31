import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/morse_state.dart';
import 'package:morse_web_play/providers/audio_provider.dart';
import 'package:morse_web_play/providers/morse_provider.dart';

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

  // Function to play the audio
  void playMorse() async {
    // Define the MorseAudioService instance
    final audioService = ref.read(audioServiceProvider);

    // Call the playMorse method found in MorseAudioService
    await audioService.playMorse(state.morseCode);
  }
}

final morseConverterProvider =
    NotifierProvider<MorseConverterNotifier, MorseConverterState>(() {
      return MorseConverterNotifier();
    });
