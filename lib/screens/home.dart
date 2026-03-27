import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/colors.dart';
import 'package:morse_web_play/providers/morse_converter_notifier.dart';
import 'package:morse_web_play/widgets/brand_bar.dart';
import 'package:morse_web_play/widgets/converter_pill.dart';

class TheHomePage extends ConsumerWidget {
  const TheHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the entire state
    final isMobile = MediaQuery.of(context).size.width < 600;
    final morseState = ref.watch(morseConverterProvider);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          BrandBar(),
          Expanded(
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              spacing: 12,
              children: [
                ConverterPill(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          "Input",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            hintText: 'Type something...',
                            hintStyle: TextStyle(color: Colors.black54),
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
                              color: violetMorse,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                ConverterPill(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          "Output",
                          style: Theme.of(context).textTheme.headlineMedium,
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
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(
                                  fontSize: 32,
                                  letterSpacing: 2,
                                ),
                          ),
                        ),
                      ),
                    ],
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
