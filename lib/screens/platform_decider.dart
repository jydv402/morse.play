import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/nav_model.dart';
import 'package:morse_web_play/providers/nav_provider.dart';
import 'package:morse_web_play/screens/home.dart';

class PlatformDecider extends ConsumerWidget {
  const PlatformDecider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current section
    final currentSection = ref.watch(navProvider);
    // Read the notifier for state changes
    final navNotifier = ref.read(navProvider.notifier);

    final destinations = const [
      NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded, color: Colors.lightGreenAccent),
        label: Text('Convert'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.book_outlined),
        selectedIcon: Icon(Icons.book_rounded, color: Colors.lightGreenAccent),
        label: Text('Book'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.favorite_border_rounded),
        selectedIcon: Icon(Icons.favorite_rounded, color: Colors.red),
        label: Text('Credits'),
      ),
    ];

    Widget getPage(AppSection section) {
      switch (section) {
        case AppSection.converter:
          return const TheHomePage();
        case AppSection.book:
          return Text("Book");
        case AppSection.credits:
          return Text("Credits");
      }
    }

    // Define the LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Small screen
          return Text("Small Screen UI");
        } else {
          // Large screen
          return Scaffold(
            appBar: AppBar(title: const Text("Morse Web Play")),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: currentSection.index,
                  onDestinationSelected: (int index) {
                    // Call the Notifier with the new section
                    navNotifier.changeSection(AppSection.values[index]);
                  },
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: Colors.black, // Match your theme
                  destinations: destinations,
                ),

                // Vertical Divider for separation
                const VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Colors.lightGreenAccent,
                ),

                Expanded(
                  child: getPage(currentSection), // Show the current screen
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
