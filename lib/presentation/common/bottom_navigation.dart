
import 'package:flutter/material.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNavigation({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: AppSize.s28),
            label: 'Chat'),
        BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy, size: AppSize.s28),
            label: 'Bot'),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: AppSize.s28),
            label: 'Prompt'),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books, size: AppSize.s28),
            label: 'Knowledge'),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
    );
  }
}
