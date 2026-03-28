import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/providers/morse_converter_notifier.dart';
import 'package:morse_web_play/widgets/brand_bar.dart';
import 'package:morse_web_play/widgets/converter_pill.dart';

class TheHomePage extends ConsumerWidget {
  const TheHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isMobile = MediaQuery.of(context).size.width < 600;
    final morseState = ref.watch(morseConverterProvider);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const BrandBar(),
          Expanded(
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              spacing: 12,
              children: [
                Expanded(
                  child: ConverterPill(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            "Input",
                            style: textTheme.headlineMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: TextField(
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              hintText: 'Type something...',
                              hintStyle: TextStyle(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              ref
                                  .read(morseConverterProvider.notifier)
                                  .textToMorse(value);
                            },
                          ),
                        ),
                        if (morseState.morseCode.isNotEmpty)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(morseConverterProvider.notifier)
                                    .playMorse();
                              },
                              icon: Icon(
                                morseState.isPlaying
                                    ? Icons.stop_circle_rounded
                                    : Icons.play_circle_filled_rounded,
                                size: 48,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ConverterPill(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Text(
                            "Output",
                            style: textTheme.headlineMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 24),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SelectableText(
                              morseState.morseCode.isEmpty
                                  ? '...'
                                  : morseState.morseCode,
                              style: textTheme.headlineMedium?.copyWith(
                                fontSize: 32,
                                letterSpacing: 2,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
