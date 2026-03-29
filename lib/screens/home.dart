import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  late final ScrollController _inputScrollController;
  late final ScrollController _outputScrollController;

  @override
  void initState() {
    super.initState();
    final initialState = ref.read(morseConverterProvider);
    _textController = TextEditingController(text: initialState.rawtext);
    _inputScrollController = ScrollController();
    _outputScrollController = ScrollController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _inputScrollController.dispose();
    _outputScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final morseState = ref.watch(morseConverterProvider);
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    // Sync the local controller if changed externally
    if (_textController.text != morseState.rawtext) {
      _textController.text = morseState.rawtext;
    }

    if (isMobile) {
      return _buildMobileUI(context, morseState);
    } else {
      return _buildDesktopUI(context, morseState);
    }
  }

  /// MOBILE UI: Expanding pills, entire page scrolls
  Widget _buildMobileUI(BuildContext context, morseState) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const BrandBar(),
          _buildPillContainer(
            context,
            label: "Input",
            child: _buildInputContent(context, morseState, expands: false),
            expands: false,
          ),
          const SizedBox(height: 12),
          _buildPillContainer(
            context,
            label: "Output",
            child: _buildOutputContent(context, morseState, expands: false),
            expands: false,
          ),
          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }

  /// DESKTOP UI: Fixed proportions, internal scrolling
  Widget _buildDesktopUI(BuildContext context, morseState) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const BrandBar(),
          Expanded(
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: _buildPillContainer(
                    context,
                    label: "Input",
                    child: _buildInputContent(
                      context,
                      morseState,
                      expands: true,
                    ),
                    expands: true,
                  ),
                ),
                Expanded(
                  child: _buildPillContainer(
                    context,
                    label: "Output",
                    child: _buildOutputContent(
                      context,
                      morseState,
                      expands: true,
                    ),
                    expands: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to build the Pill with Column layout
  Widget _buildPillContainer(
    BuildContext context, {
    required String label,
    required Widget child,
    required bool expands,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ConverterPill(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            label,
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          expands ? Expanded(child: child) : child,
        ],
      ),
    );
  }

  Widget _buildInputContent(
    BuildContext context,
    morseState, {
    required bool expands,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final double fontSize = 22;
    final double lineHeight = 1.4;

    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: colorScheme.onSurface,
      fontSize: fontSize,
      height: lineHeight,
    );

    final strutStyle = StrutStyle(
      fontSize: fontSize,
      height: lineHeight,
      forceStrutHeight: true,
    );

    Widget textField = TextField(
      controller: _textController,
      scrollController: _inputScrollController,
      style: textStyle,
      strutStyle: strutStyle,
      maxLines: null,
      expands: expands,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: 'Type something...',
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.3),
        ),
        border: InputBorder.none,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
      ),
      onChanged: (value) {
        ref.read(morseConverterProvider.notifier).textToMorse(value);
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            textField,
            if (morseState.isPlaying && morseState.currentRawIndex != -1)
              _ProgressIndicatorPill(
                text: morseState.rawtext,
                currentIndex: morseState.currentRawIndex,
                style: textStyle!,
                strutStyle: strutStyle,
                scrollOffset: _inputScrollController.hasClients
                    ? _inputScrollController.offset
                    : 0,
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
              ),
          ],
        );
      },
    );
  }

  Widget _buildOutputContent(
    BuildContext context,
    morseState, {
    required bool expands,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final double fontSize = 28;
    final double lineHeight = 1.4;

    final textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontSize: fontSize,
      letterSpacing: 2,
      color: colorScheme.onSurface,
      height: lineHeight,
    );

    final strutStyle = StrutStyle(
      fontSize: fontSize,
      height: lineHeight,
      forceStrutHeight: true,
    );

    Widget outputText = SelectableText(
      morseState.morseCode.isEmpty ? '...' : morseState.morseCode,
      style: textStyle,
      strutStyle: strutStyle,
      scrollPhysics: const BouncingScrollPhysics(),
    );

    Widget content = expands
        ? SingleChildScrollView(
            controller: _outputScrollController,
            child: outputText,
          )
        : outputText;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            content,
            if (morseState.isPlaying && morseState.currentMorseIndex != -1)
              _ProgressIndicatorPill(
                text: morseState.morseCode,
                currentIndex: morseState.currentMorseIndex,
                style: textStyle!,
                strutStyle: strutStyle,
                scrollOffset: _outputScrollController.hasClients
                    ? _outputScrollController.offset
                    : 0,
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
              ),
          ],
        );
      },
    );
  }
}

class _ProgressIndicatorPill extends StatelessWidget {
  final String text;
  final int currentIndex;
  final TextStyle style;
  final StrutStyle strutStyle;
  final double scrollOffset;
  final double maxWidth;
  final double maxHeight;

  const _ProgressIndicatorPill({
    required this.text,
    required this.currentIndex,
    required this.style,
    required this.strutStyle,
    required this.scrollOffset,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (currentIndex < 0 || currentIndex >= text.length) {
      return const SizedBox();
    }

    // Layout the text to find the character position
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(context).textScaler,
      strutStyle: strutStyle,
    )..layout(maxWidth: maxWidth);

    final Offset offset = tp.getOffsetForCaret(
      TextPosition(offset: currentIndex),
      Rect.zero,
    );

    final double topPosition = offset.dy - scrollOffset;

    // Hide if scrolled out
    if (topPosition < -20 || topPosition > maxHeight) {
      return const SizedBox();
    }

    // Calculate current character width
    final currentLetterTp = TextPainter(
      text: TextSpan(text: text[currentIndex], style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(context).textScaler,
      strutStyle: strutStyle,
    )..layout();

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
      top: topPosition + tp.preferredLineHeight - 4,
      left: offset.dx,
      child: Container(
        width: currentLetterTp.width,
        height: 6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
