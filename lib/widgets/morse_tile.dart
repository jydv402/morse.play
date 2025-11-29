import 'package:flutter/material.dart';
import 'package:morse_web_play/models/colors.dart';

class MorseTiles extends StatelessWidget {
  final String char;
  final String code;
  const MorseTiles({super.key, required this.char, required this.code});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: pillsBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(children: [Text(char), Text(code)]),
      ),
    );
  }
}
