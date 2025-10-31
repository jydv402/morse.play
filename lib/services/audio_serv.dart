import 'package:audioplayers/audioplayers.dart';

class MorseAudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // 1 unit duration = 60ms
  static const int _unitDuration = 80;

  // Dot duration is one unit
  final int _dotDuration = _unitDuration;

  // Dash duration is 3 units
  final int _dashDuration = _unitDuration * 3;

  // 1 unit (Intra-element space)
  final int _pauseDuration = _unitDuration;

  // 3 units (Inter-letter space)
  final int _letterPauseDuration = 3 * _unitDuration;

  // 7 units (Inter-word space)
  final int _wordPauseDuration = 7 * _unitDuration;

  // Bool for player state
  bool isPlaying = false;

  // Global service function
  Future<void> playMorse(String morseCode) async {
    // Set playing to true
    isPlaying = true;

    // Small initial delay to ensure the player is ready
    await Future.delayed(const Duration(milliseconds: 50));

    // Iteratively call the _playBeep function
    for (var i = 0; i < morseCode.length; i++) {
      // Obtain the current Morse character
      final curr = morseCode[i];

      if (!isPlaying) break;

      switch (curr) {
        case '.':
          await _playBeep(_dotDuration);
          // Pause after the dot (intra-element space)
          await Future.delayed(Duration(milliseconds: _pauseDuration));
          break;

        case '-':
          await _playBeep(_dashDuration);
          // Pause after the dash (intra-element space)
          await Future.delayed(Duration(milliseconds: _pauseDuration));
          break;

        case ' ':
          if (i < morseCode.length - 1 && morseCode[i + 1] == ' ') {
            // It is a word break
            await Future.delayed(Duration(milliseconds: _wordPauseDuration));
            // Exclude next space
            i++;
          } else {
            // It is a letter break
            await Future.delayed(Duration(milliseconds: _letterPauseDuration));
          }
          break;

        // Ignore other characters
        default:
          break;
      }
    }

    // Set playing to false at the end
    isPlaying = false;
  }

  // The audio player function
  Future<void> _playBeep(int duration) async {
    // Play the audio
    await _audioPlayer.play(AssetSource('beep.mp3'), volume: 0.5);
    // Continue playing the audio
    await Future.delayed(Duration(milliseconds: duration));
    // Stop the audio
    await _audioPlayer.stop();
  }

  // Audio stop function
  void stopAudio() async {
    isPlaying = false;
    await _audioPlayer.stop();
  }

  // Cleanup function
  void dispose() {
    _audioPlayer.dispose();
  }
}
