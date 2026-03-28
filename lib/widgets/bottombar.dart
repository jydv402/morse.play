import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/providers/theme_provider.dart';

class BottomBar extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final navItems = [
      (Ph.house_duotone, Ph.house_fill, 'Convert'),
      (Ph.book_duotone, Ph.book_open_fill, 'Book'),
      (Ph.heart_duotone, Ph.heart_fill, 'Credits'),
    ];

    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(1.5, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Sliding Pill Background
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutSine,
                  alignment: Alignment(-1 + currentIndex.toDouble(), 0),
                  child: FractionallySizedBox(
                    widthFactor: 1 / navItems.length,
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                // Navigation Icons
                Row(
                  children: [
                    for (int i = 0; i < navItems.length; i++)
                      Expanded(
                        child: InkWell(
                          onTap: () => onTap(i),
                          borderRadius: BorderRadius.circular(16),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Iconify(
                                  currentIndex == i
                                      ? navItems[i].$2
                                      : navItems[i].$1,
                                  color: currentIndex == i
                                      ? Colors.white
                                      : (isDark
                                            ? Colors.white60
                                            : Colors.black54),
                                  size: 26,
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: currentIndex == i
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: Text(
                                            navItems[i].$3,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const VerticalDivider(width: 1, indent: 10, endIndent: 10),
          // Theme Switcher
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              ref
                  .read(themeProvider.notifier)
                  .toggleTheme(Theme.of(context).brightness);
            },
            icon: Iconify(
              isDark ? Ph.moon_fill : Ph.sun_fill,
              color: isDark ? colorScheme.primary : Colors.amber,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
