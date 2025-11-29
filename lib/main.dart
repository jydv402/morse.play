import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/theme.dart';
import 'package:morse_web_play/screens/platform_decider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'morse.play',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: PlatformDecider(),
    );
  }
}
