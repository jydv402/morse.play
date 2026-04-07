import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/nav_model.dart';
import 'package:morse_web_play/providers/nav_provider.dart';
import 'package:morse_web_play/screens/book.dart';
import 'package:morse_web_play/screens/home.dart';
import 'package:morse_web_play/widgets/bottombar.dart';
import 'package:morse_web_play/widgets/sidebar.dart';
import 'package:morse_web_play/screens/credits.dart';
import 'package:morse_web_play/widgets/fab.dart';

class PlatformDecider extends ConsumerWidget {
  const PlatformDecider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current section
    final currentSection = ref.watch(navProvider);
    // Read the notifier for state changes
    final navNotifier = ref.read(navProvider.notifier);

    // List of pages to be kept alive in IndexedStack
    final pages = [
      const MorseConverterView(),
      const BookPage(),
      const CreditsPage(),
    ];

    // Define the LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Small screen
          return Scaffold(
            body: IndexedStack(index: currentSection.index, children: pages),
            bottomNavigationBar: BottomBar(
              currentIndex: currentSection.index,
              onTap: (int index) {
                navNotifier.changeSection(AppSection.values[index]);
              },
            ),
            // Show FAB only on Home section with custom fade animation
            floatingActionButton: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: currentSection == AppSection.converter
                  ? const MorseFloatingButtons(
                      key: ValueKey('fab'),
                      isMobile: true,
                    )
                  : const SizedBox.shrink(key: ValueKey('none')),
            ),
          );
        } else {
          // Large screen
          return Scaffold(
            body: Row(
              children: [
                CustomSidebar(
                  selectedSection: currentSection,
                  onSectionSelected: (value) =>
                      navNotifier.changeSection(value),
                  maxWidth: constraints.maxWidth,
                  expanded: constraints.maxWidth > 1000,
                ),
                Expanded(
                  child: IndexedStack(
                    index: currentSection.index,
                    children: pages,
                  ),
                ),
              ],
            ),
            // Show FAB only on Home section with custom fade animation
            floatingActionButton: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: currentSection == AppSection.converter
                  ? const MorseFloatingButtons(
                      key: ValueKey('fab'),
                      isMobile: false,
                    )
                  : const SizedBox.shrink(key: ValueKey('none')),
            ),
          );
        }
      },
    );
  }
}
