import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/models/colors.dart';
import 'package:morse_web_play/models/nav_model.dart';

class CustomSidebar extends StatelessWidget {
  final AppSection selectedSection;
  final ValueChanged<AppSection> onSectionSelected;
  final double maxWidth;
  final bool expanded;

  const CustomSidebar({
    super.key,
    required this.selectedSection,
    required this.onSectionSelected,
    required this.maxWidth,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final barItems = [
      (AppSection.converter, Ph.house_duotone, Ph.house_fill, 'Convert'),
      (AppSection.book, Ph.book_duotone, Ph.book_open_fill, 'Book'),
      (AppSection.credits, Ph.heart_duotone, Ph.heart_fill, 'Credits'),
    ];

    return Container(
      width: maxWidth > 1000 ? 200 : 80,
      margin: const EdgeInsets.fromLTRB(12, 12, 0, 12),
      decoration: BoxDecoration(
        color: pillsBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          // Nav items
          for (final (section, icon, selectedIcon, label) in barItems)
            _SidebarItem(
              isSelected: section == selectedSection,
              icon: icon,
              selectedIcon: selectedIcon,
              label: label,
              onTap: () => onSectionSelected(section),
              expanded: expanded,
            ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final bool isSelected;
  final String icon;
  final String selectedIcon;
  final String label;
  final VoidCallback onTap;
  final bool expanded;

  const _SidebarItem({
    required this.isSelected,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : Colors.black54;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: violetMorse,
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? violetMorse : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: expanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            spacing: 6,
            children: [
              Iconify(isSelected ? selectedIcon : icon, color: color, size: 24),
              const SizedBox(height: 4),
              if (expanded) Text(label, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
