import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/colors.dart';
import 'package:morse_web_play/models/nav_model.dart';
import 'package:morse_web_play/providers/nav_provider.dart';
import 'package:morse_web_play/screens/book.dart';
import 'package:morse_web_play/screens/home.dart';
import 'package:morse_web_play/widgets/bottombar.dart';
import 'package:morse_web_play/widgets/sidebar.dart';
import 'package:morse_web_play/screens/credits.dart';

class PlatformDecider extends ConsumerWidget {
  const PlatformDecider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current section
    final currentSection = ref.watch(navProvider);
    // Read the notifier for state changes
    final navNotifier = ref.read(navProvider.notifier);

    Widget getPage(AppSection section) {
      switch (section) {
        case AppSection.converter:
          return const TheHomePage();
        case AppSection.book:
          return const BookPage();
        case AppSection.credits:
          return const CreditsPage();
      }
    }

    // Define the LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Small screen
          return Scaffold(
            backgroundColor: lightBg,
            body: getPage(currentSection),
            bottomNavigationBar: BottomBar(
              currentIndex: currentSection.index,
              onTap: (int index) {
                navNotifier.changeSection(AppSection.values[index]);
              },
              boxColor: pillsBg,
              selectedColor: violetMorse,
            ),
          );
        } else {
          // Large screen
          return Scaffold(
            backgroundColor: lightBg,
            body: Row(
              children: [
                CustomSidebar(
                  selectedSection: currentSection,
                  onSectionSelected: (value) =>
                      navNotifier.changeSection(value),
                  maxWidth: constraints.maxWidth,
                  expanded: constraints.maxWidth > 1000,
                ),
                Expanded(child: getPage(currentSection)),
              ],
            ),
          );
        }
      },
    );
  }
}
