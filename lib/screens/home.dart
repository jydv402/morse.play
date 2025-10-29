import 'package:morse_web_play/barrel.dart';

class TheHomePage extends ConsumerWidget {
  const TheHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final morseService = ref.watch(morseServiceProvider);
    final textController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: textController),
            Text("Morse"),
          ],
        ),
      ),
    );
  }
}
