import 'package:morse_web_play/barrel.dart';

// Morse service provider
final morseServiceProvider = Provider<MorseService>((ref) {
  // returns a new MorseService instance.
  return MorseService();
});
