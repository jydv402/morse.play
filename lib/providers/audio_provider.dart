// Audio service provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/services/audio_serv.dart';

final audioServiceProvider = Provider<MorseAudioService>((ref) {
  // Create the audio service instance
  final audioService = MorseAudioService();

  // Calls on autodispose by Riverpod, and thus disposes the audioplayer too
  ref.onDispose(() => audioService.dispose());

  // Return the audio service instance
  return audioService;
});
