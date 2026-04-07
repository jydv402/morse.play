import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/providers/morse_converter_notifier.dart';

class MorseFloatingButtons extends ConsumerWidget {
  final bool isMobile;
  const MorseFloatingButtons({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final morseState = ref.watch(morseConverterProvider);
    final colorScheme = Theme.of(context).colorScheme;

    // Set the icon size for the FAB
    double iconSize = isMobile ? 14 : 28;
    double padding = isMobile ? 4 : 8;
    double borderRadius = isMobile ? 16 : 24;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: padding,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: padding * 2,
            vertical: padding,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(borderRadius),
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
          padding: EdgeInsets.symmetric(
            horizontal: padding * 2,
            vertical: padding,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: padding * 2,
            children: [
              // Clear button
              IconButton(
                tooltip: 'Clear',
                onPressed: () {
                  ref.read(morseConverterProvider.notifier).clearAll();
                },
                icon: Iconify(
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
                icon: Iconify(
                  Ph.copy_simple_duotone,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: padding * 2,
            vertical: padding,
          ),
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: IconButton(
            tooltip: 'Swap',
            onPressed: () {
              ref.read(morseConverterProvider.notifier).toggleMode();
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
