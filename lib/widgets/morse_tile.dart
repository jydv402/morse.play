import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/providers/book_audio_provider.dart';

/// A widget that displays a single morse code tile with playback functionality.
/// Optimized with RepaintBoundary for better grid performance.
class MorseTiles extends ConsumerWidget {
  final String char;
  final String code;
  const MorseTiles({super.key, required this.char, required this.code});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPlaying = ref.watch(bookAudioProvider.select((c) => c == char));

    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              code,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              char,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: colorScheme.primary,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                ref.read(bookAudioProvider.notifier).playMorse(char, code);
              },
              icon: Icon(
                isPlaying
                    ? Icons.stop_circle_rounded
                    : Icons.play_circle_filled_rounded,
                color: isPlaying ? colorScheme.error : colorScheme.primary,
                size: 28,
              ),
              splashRadius: 20,
              tooltip: isPlaying ? 'Stop' : 'Play',
            ),
          ],
        ),
      ),
    );
  }
}
