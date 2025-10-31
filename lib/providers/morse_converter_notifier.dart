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

    if (state.isPlaying) {
      audioService.stopAudio();
      state = state.copyWith(isPlaying: false);
      return;
    }

    // Set isplaying to true
    state = state.copyWith(isPlaying: true);

    // Call the playMorse method found in MorseAudioService
    try {
      await audioService.playMorse(state.morseCode);
    } catch (e) {
      // Handle any errors during playback
      print("Audio playback error: $e");
    } finally {
      // Set isplaying to false
      state = state.copyWith(isPlaying: false);
    }
  }
}

final morseConverterProvider =
    NotifierProvider<MorseConverterNotifier, MorseConverterState>(() {
      return MorseConverterNotifier();
    });
