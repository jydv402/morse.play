import 'package:flutter/material.dart';
import 'package:morse_web_play/models/colors.dart';

/// A widget that displays a pill-shaped container for converter widgets.
/// Defines the shaped container
class ConverterPill extends StatelessWidget {
  final Widget child;
  const ConverterPill({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Expanded(
      child: Container(
        height: isMobile ? 300 : MediaQuery.of(context).size.height - 116,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: pillsBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: child,
      ),
    );
  }
}
