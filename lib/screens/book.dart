import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/providers/morse_provider.dart';

class BookPage extends ConsumerStatefulWidget {
  const BookPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  @override
  Widget build(BuildContext context) {
    final morse = ref.watch(morseServiceProvider);

    return ListView.builder(
      itemCount: morse.morseCode.length,

      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            "${morse.morseCode.keys.toList()[index]} = ${morse.morseCode.values.toList()[index]}",
          ),
        );
      },
    );
  }
}
