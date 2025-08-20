// lib/shared/widgets/footer_nav.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FooterNav extends StatelessWidget {
  const FooterNav({super.key, required this.index});
  final int index;

  void _onTap(BuildContext context, int i) {
    switch (i) {
      case 0: context.go('/home'); break;
      case 1: context.go('/tasks'); break;
      case 2: context.go('/leaderboard'); break;
      case 3: context.go('/projects'); break;
      case 4: context.go('/profiles'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) => _onTap(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.house_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.checklist_outlined), label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), label: 'Rank'),
        BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Projects'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'Profiles'),
      ],
    );
  }
}
