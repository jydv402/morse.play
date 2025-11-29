import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/models/colors.dart';

class BrandBar extends StatelessWidget {
  const BrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: pillsBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Spacer(),
          Text("morse.play", style: GoogleFonts.nabla(fontSize: 36)),
          Spacer(),
          InkWell(
            onTap: () {
              // TODO: Add link
            },
            child: Iconify(
              Ph.github_logo_duotone,
              size: 28,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
