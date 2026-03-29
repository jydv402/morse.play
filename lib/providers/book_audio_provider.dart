import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/providers/audio_provider.dart';
import 'package:morse_web_play/utils/logger.dart';

class BookAudioNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void playMorse(String char, String morseCode) async {
    final audioService = ref.read(audioServiceProvider);

    // If already playing this char, stop it
    if (state == char) {
      stopMorse();
      return;
    }

    // If another char is playing, stop it first
    if (state != null) {
      audioService.stopAudio();
    }

    // Set active char
    state = char;

    try {
      await audioService.playMorse(char, morseCode);
    } catch (e) {
      // Handle playback errors
      logger.e("Audio playback error in Book: $e");
    } finally {
      // Clear only if we are still the active char, to avoid clearing a newly started char
      if (state == char) {
        state = null;
      }
    }
  }

  void stopMorse() {
    final audioService = ref.read(audioServiceProvider);
    audioService.stopAudio();
    state = null;
  }
}

final bookAudioProvider = NotifierProvider<BookAudioNotifier, String?>(() {
  return BookAudioNotifier();
});
