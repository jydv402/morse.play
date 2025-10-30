import 'package:morse_web_play/barrel.dart';

class TheHomePage extends ConsumerWidget {
  const TheHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final morseState = ref.watch(morseConverterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("morse.play"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Section
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Type something...',
                hintStyle: TextStyle(color: Colors.grey.withAlpha(100)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.lightGreenAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.lightGreenAccent.withAlpha(100),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.lightGreenAccent,
                    width: 2,
                  ),
                ),
              ),
              maxLines: 5,
              onChanged: (value) {
                // Call the textToMorse method
                ref.read(morseConverterProvider.notifier).textToMorse(value);
              },
            ),

            const SizedBox(height: 40),

            // Output Text Widget
            Text(
              "Morse Output:",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent.withAlpha(100),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.lightGreenAccent.withAlpha(100),
                ),
              ),
              child: Text(
                // If the morse code is empty, display '...'
                morseState.morseCode.isEmpty ? '...' : morseState.morseCode,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontSize: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
