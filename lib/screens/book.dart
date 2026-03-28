import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/services/morse_serv.dart';
import 'package:morse_web_play/widgets/morse_tile.dart';

class BookPage extends ConsumerStatefulWidget {
  const BookPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: GridView.builder(
          itemCount: MorseService.bookEntries.length,
          clipBehavior: Clip.antiAlias,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // Dynamically calculate the number of columns based on the screen width
            crossAxisCount: min(width ~/ 200, 5),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final entry = MorseService.bookEntries[index];
            return MorseTiles(
              key: ValueKey(entry.char),
              char: entry.char,
              code: entry.code,
            );
          },
        ),
      ),
    );
  }
}
