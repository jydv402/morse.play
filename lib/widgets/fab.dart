import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/providers/morse_converter_notifier.dart';

class MorseFloatingButtons extends ConsumerWidget {
  const MorseFloatingButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final morseState = ref.watch(morseConverterProvider);
    final colorScheme = Theme.of(context).colorScheme;

    // Set the icon size for the FAB
    const double iconSize = 28;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: // Play FAB
          IconButton(
            tooltip: morseState.isPlaying ? 'Stop' : 'Play',
            onPressed: () {
              ref.read(morseConverterProvider.notifier).playMorse();
            },
            icon: Iconify(
              morseState.isPlaying ? Ph.stop_duotone : Ph.play_duotone,
              size: iconSize,
              color: morseState.isPlaying ? Colors.red.shade300 : Colors.white,
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              // Clear button
              IconButton(
                tooltip: 'Clear',
                onPressed: () {
                  ref.read(morseConverterProvider.notifier).clearAll();
                },
                icon: const Iconify(
                  Ph.trash_duotone,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
              // Copy FAB
              IconButton(
                tooltip: 'Copy Morse Code',
                onPressed: () {
                  ref.read(morseConverterProvider.notifier).copyMorse();
                },
                icon: const Iconify(
                  Ph.copy_simple_duotone,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: IconButton(
            tooltip: 'Swap',
            onPressed: () {
              // TODO : Swap mode from text to morse and vice versa
            },
            icon: Iconify(
              Ph.arrows_left_right_duotone,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
