import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    // Default to system theme as requested by the user.
    return ThemeMode.system;
  }

  void toggleTheme(Brightness currentBrightness) {
    if (state == ThemeMode.system) {
      state = currentBrightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }
  }

  void setTheme(ThemeMode mode) {
    state = mode;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
);
