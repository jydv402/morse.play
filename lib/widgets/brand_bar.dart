import 'package:flutter/material.dart';
import 'package:morse_web_play/models/colors.dart';

class BrandBar extends StatelessWidget {
  const BrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: pillsBg,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
