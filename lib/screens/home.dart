import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/providers/morse_converter_notifier.dart';
import 'package:morse_web_play/widgets/brand_bar.dart';
import 'package:morse_web_play/widgets/converter_pill.dart';

class TheHomePage extends ConsumerWidget {
  const TheHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the entire state
    final morseState = ref.watch(morseConverterProvider);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          BrandBar(),
          Flex(
            direction: Axis.horizontal,

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
                        decoration: InputDecoration(
                          hintText: 'Type something...',
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                        onChanged: (value) {
                          // Call the textToMorse method
                          ref
                              .read(morseConverterProvider.notifier)
                              .textToMorse(value);
                        },
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
                        child: SizedBox(
                          child: SelectableText(
                            // If the morse code is empty, display '...'
                            morseState.morseCode.isEmpty
                                ? '...'
                                : morseState.morseCode,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(fontSize: 32),

                            //overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     neoContainer(Colors.lightGreenAccent),

      //     // Input Section
      //     TextField(
      //       style: Theme.of(context).textTheme.bodyMedium,
      //       decoration: InputDecoration(
      //         hintText: 'Type something...',
      //         hintStyle: TextStyle(color: Colors.grey.withAlpha(100)),
      //         border: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(12),
      //           borderSide: const BorderSide(color: Colors.lightGreenAccent),
      //         ),
      //         enabledBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(12),
      //           borderSide: BorderSide(
      //             color: Colors.lightGreenAccent.withAlpha(100),
      //           ),
      //         ),
      //         focusedBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(12),
      //           borderSide: const BorderSide(
      //             color: Colors.lightGreenAccent,
      //             width: 2,
      //           ),
      //         ),
      //       ),
      //       maxLines: 5,
      //       onChanged: (value) {
      //         // Call the textToMorse method
      //         ref.read(morseConverterProvider.notifier).textToMorse(value);
      //       },
      //     ),

      //     const SizedBox(height: 40),

      //     // Output Text Widget
      //     Text(
      //       "Morse Output:",
      //       style: Theme.of(context).textTheme.headlineSmall,
      //     ),
      //     const SizedBox(height: 10),
      //     Container(
      //       padding: const EdgeInsets.all(20),
      //       decoration: BoxDecoration(
      //         color: Colors.lightGreenAccent.withAlpha(100),
      //         borderRadius: BorderRadius.circular(12),
      //         border: Border.all(color: Colors.lightGreenAccent.withAlpha(100)),
      //       ),
      //       child: Text(
      //         // If the morse code is empty, display '...'
      //         morseState.morseCode.isEmpty ? '...' : morseState.morseCode,
      //         style: Theme.of(
      //           context,
      //         ).textTheme.headlineMedium?.copyWith(fontSize: 32),
      //       ),
      //     ),

      //     const SizedBox(height: 10),

      //     // Play Button to play the audio
      //     if (morseState.morseCode.isNotEmpty)
      //       ElevatedButton.icon(
      //         onPressed: () {
      //           // Call the playMorse method
      //           ref.read(morseConverterProvider.notifier).playMorse();
      //         },
      //         label: morseState.isPlaying
      //             ? Icon(Icons.stop)
      //             : Icon(Icons.play_arrow_outlined),
      //       ),
      //   ],
      // ),
    );
  }
}
