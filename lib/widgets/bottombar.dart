import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color boxColor;
  final Color selectedColor;
  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.boxColor,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final barDestinations = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_rounded),
        label: 'Convert',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book_outlined),
        activeIcon: Icon(Icons.book_rounded),
        label: 'Book',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_rounded),
        activeIcon: Icon(Icons.favorite_rounded),
        label: 'Credits',
      ),
    ];

    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: barDestinations,
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: selectedColor,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
