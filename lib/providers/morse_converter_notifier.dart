import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/morse_state.dart';
import 'package:morse_web_play/providers/audio_provider.dart';
import 'package:morse_web_play/services/morse_serv.dart';

class MorseConverterNotifier extends Notifier<MorseConverterState> {
  @override
  MorseConverterState build() {
    return const MorseConverterState();
  }

  /// Offloads the text-to-morse conversion to a background Isolate
  /// using Flutter's compute function.
  void textToMorse(String text) async {
    // If input is very small, convert directly to avoid isolate overhead
    if (text.length < 50) {
      final morseCode = MorseService.convert(text);
      state = state.copyWith(morseCode: morseCode, rawtext: text);
      return;
    }

    // Create a local copy of text
    final input = text;

    // Use compute to perform the conversion on a separate thread
    final morseCode = await compute(MorseService.convert, input);

    // Ensure the state update is only applied if the input hasn't changed
    // in the meantime (optional check, depends on desired UX)
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
      debugPrint("Audio playback error: $e");
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
