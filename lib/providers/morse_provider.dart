import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/services/morse_serv.dart';
// Morse service provider

final morseServiceProvider = Provider<MorseService>((ref) {
  // returns a new MorseService instance.
  return MorseService();
});
