import 'package:flutter/material.dart';
import 'package:morse_web_play/models/colors.dart';

class ConverterPill extends StatelessWidget {
  final String headText;
  final Widget child;
  const ConverterPill({super.key, required this.headText, required this.child});

  @override
  Widget build(BuildContext context) {
    // Return expanded containers
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: pillsBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headText, style: Theme.of(context).textTheme.headlineLarge),
            child,
          ],
        ),
      ),
    );
  }
}
