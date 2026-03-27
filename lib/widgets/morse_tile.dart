import 'package:flutter/material.dart';
import 'package:morse_web_play/models/colors.dart';

/// A widget that displays a single morse code tile.
/// Used in the morse code book.
class MorseTiles extends StatelessWidget {
  final String char;
  final String code;
  const MorseTiles({super.key, required this.char, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: pillsBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            code,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            char,
            style: TextStyle(
              fontSize: 18,
              color: violetMorse,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
