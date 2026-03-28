import 'package:flutter/material.dart';

/// A widget that displays a pill-shaped container for converter widgets.
/// Defines the shaped container
class ConverterPill extends StatelessWidget {
  final Widget child;
  const ConverterPill({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // Width is now handled by the parent (Expanded/Flexible)
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}
