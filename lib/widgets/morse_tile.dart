import 'package:flutter/material.dart';

/// A widget that displays a single morse code tile.
/// Used in the morse code book.
class MorseTiles extends StatelessWidget {
  final String char;
  final String code;
  const MorseTiles({super.key, required this.char, required this.code});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            code,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            char,
            style: TextStyle(
              fontSize: 18,
              color: colorScheme.primary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
