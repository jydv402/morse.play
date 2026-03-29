import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/providers/morse_converter_notifier.dart';
import 'package:morse_web_play/widgets/brand_bar.dart';
import 'package:morse_web_play/widgets/converter_pill.dart';

class MorseConverterView extends ConsumerStatefulWidget {
  const MorseConverterView({super.key});

  @override
  ConsumerState<MorseConverterView> createState() => _MorseConverterViewState();
}

class _MorseConverterViewState extends ConsumerState<MorseConverterView> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current state value
    final initialState = ref.read(morseConverterProvider);
    _textController = TextEditingController(text: initialState.rawtext);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Check if the device is mobile
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    // Set the icon size based on mobile/desktop
    final double iconSize = isMobile ? 30 : 40;

    // Watch the current state (Riverpod)
    final morseState = ref.watch(morseConverterProvider);

    // Sync the local controller if the state changed from outside
    if (_textController.text != morseState.rawtext) {
      _textController.text = morseState.rawtext;
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const BrandBar(),
          const SizedBox(height: 12),
          Expanded(
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              spacing: 12,
              children: [
                // INPUT SECTION
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
                            controller: _textController,
                            autofocus: true,
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 20,
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
                      ],
                    ),
                  ),
                ),
                // OUTPUT SECTION
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
                          padding: const EdgeInsets.only(top: 50, bottom: 48),
                          child: SingleChildScrollView(
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
                        if (morseState.morseCode.isNotEmpty)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [
                                // Copy button
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(morseConverterProvider.notifier)
                                        .copyMorse();
                                  },
                                  icon: Iconify(
                                    Ph.copy_simple_duotone,
                                    size: iconSize,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                // Play button
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(morseConverterProvider.notifier)
                                        .playMorse();
                                  },
                                  icon: Iconify(
                                    morseState.isPlaying
                                        ? Ph.stop_duotone
                                        : Ph.play_duotone,
                                    size: iconSize,
                                    color: morseState.isPlaying
                                        ? Colors.red.shade300
                                        : colorScheme.primary,
                                  ),
                                ),
                              ],
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
