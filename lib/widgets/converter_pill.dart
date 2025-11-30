import 'package:flutter/material.dart';
import 'package:morse_web_play/models/colors.dart';

class ConverterPill extends StatelessWidget {
  final Widget child;
  const ConverterPill({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Return expanded containers
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height - 116,
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: pillsBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: child,
      ),
    );
  }
}
