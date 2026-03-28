import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/providers/morse_provider.dart';
import 'package:morse_web_play/widgets/morse_tile.dart';

class BookPage extends ConsumerStatefulWidget {
  const BookPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  @override
  Widget build(BuildContext context) {
    final morse = ref.watch(morseServiceProvider);
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: GridView.builder(
          itemCount: morse.morseCode.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // Dynamically calculate the number of columns based on the screen width
            crossAxisCount: min(width ~/ 200, 5),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return MorseTiles(
              char: morse.morseCode.keys.toList()[index],
              code: morse.morseCode.values.toList()[index],
            );
          },
        ),
      ),
    );
  }
}
