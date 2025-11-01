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

    final barDestinations = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_rounded, color: Colors.lightGreenAccent),
        label: 'Convert',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book_outlined),
        activeIcon: Icon(Icons.book_rounded, color: Colors.lightGreenAccent),
        label: 'Book',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_rounded),
        activeIcon: Icon(
          Icons.favorite_rounded,
          color: Colors.lightGreenAccent,
        ),
        label: 'Credits',
      ),
    ];

    final railDestinations = const [
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
          return SafeArea(
            child: Scaffold(
              body: getPage(currentSection),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: barDestinations,
                currentIndex: currentSection.index,
                onTap: (int index) {
                  // Call the Notifier with the new section
                  navNotifier.changeSection(AppSection.values[index]);
                },
                backgroundColor: Colors.black,
                selectedItemColor: Colors.lightGreenAccent,
                unselectedItemColor: Colors.grey,
              ),
            ),
          );
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
                  destinations: railDestinations,
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
