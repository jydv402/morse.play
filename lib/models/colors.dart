import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Theme Colors
const Color lightBg = Color(0xFFE9ECED);
const Color pillsBg = Color(0xFFF5F5F5);
const Color violetMorse = Color(0xFFA28EF9);
const Color greenMorse = Color(0xFFA4F5A6);
const Color textLight = Color(0xFF141A1C);

// Dark Theme Colors
const Color darkBg = Color(0xFF000000);
const Color darkPillsBg = Color(0xFF1B2123);
const Color darkVioletMorse = Color(0xFF8B7AF2);
const Color darkGreenMorse = Color(0xFF8AE08C);
const Color textDark = Color(0xFFE9ECED);

// Themes
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: lightBg,
  colorScheme: ColorScheme.light(
    primary: violetMorse,
    secondary: greenMorse,
    surface: pillsBg,
    onSurface: textLight,
    primaryContainer: violetMorse.withValues(alpha: 0.2),
  ),
  textTheme: GoogleFonts.lexendTextTheme().apply(
    bodyColor: textLight,
    displayColor: textLight,
  ),
  dividerTheme: const DividerThemeData(color: Colors.black12),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: darkBg,
  colorScheme: ColorScheme.dark(
    primary: darkVioletMorse,
    secondary: darkGreenMorse,
    surface: darkPillsBg,
    onSurface: textDark,
    primaryContainer: darkVioletMorse.withValues(alpha: 0.2),
  ),
  textTheme: GoogleFonts.lexendTextTheme().apply(
    bodyColor: textDark,
    displayColor: textDark,
  ),
  dividerTheme: const DividerThemeData(color: Colors.white12),
);
