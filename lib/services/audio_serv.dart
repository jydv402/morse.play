import 'package:audioplayers/audioplayers.dart';

class MorseAudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // 1 unit duration = 80ms
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

  // Progress callback
  void Function(int rawIndex, int morseIndex)? onProgress;

  // Global service function
  Future<void> playMorse(String rawText, String morseCode) async {
    // Ensure any previous loop is stopped
    stopAudio();
    
    // Set playing to true
    isPlaying = true;

    // Small initial delay to ensure the player is ready
    await Future.delayed(const Duration(milliseconds: 50));

    int rawIndex = 0;
    
    // Iteratively call the _playBeep function
    for (var i = 0; i < morseCode.length; i++) {
      if (!isPlaying) break;

      // Notify progress for each dot/dash/space
      onProgress?.call(rawIndex, i);

      final curr = morseCode[i];

      switch (curr) {
        case '.':
          await _playBeep(_dotDuration);
          if (isPlaying) await Future.delayed(Duration(milliseconds: _pauseDuration));
          break;

        case '-':
          await _playBeep(_dashDuration);
          if (isPlaying) await Future.delayed(Duration(milliseconds: _pauseDuration));
          break;

        case ' ':
          // Detect word break (3 spaces) vs letter break (1 space)
          // MorseService.convert uses '   ' for word breaks
          if (i + 2 < morseCode.length && morseCode[i + 1] == ' ' && morseCode[i + 2] == ' ') {
            // It is a word break
            if (isPlaying) await Future.delayed(Duration(milliseconds: _wordPauseDuration));
            i += 2; // Skip the other two spaces
            rawIndex++; // Source character was a space
          } else {
            // It is a letter break
            if (isPlaying) await Future.delayed(Duration(milliseconds: _letterPauseDuration));
            rawIndex++; // Source character finished
          }
          break;

        default:
          break;
      }
    }

    // Reset progress at the end
    onProgress?.call(-1, -1);
    isPlaying = false;
  }

  // The audio player function
  Future<void> _playBeep(int duration) async {
    if (!isPlaying) return;
    try {
      await _audioPlayer.play(AssetSource('beep.mp3'), volume: 0.5);
      await Future.delayed(Duration(milliseconds: duration));
      await _audioPlayer.stop();
    } catch (e) {
      // Ignore audio errors during rapid play/stop
    }
  }

  // Audio stop function
  void stopAudio() {
    isPlaying = false;
    _audioPlayer.stop();
    onProgress?.call(-1, -1);
  }

  // Cleanup function
  void dispose() {
    _audioPlayer.dispose();
  }
}
