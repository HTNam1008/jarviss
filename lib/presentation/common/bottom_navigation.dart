
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
            icon: Image.asset(
              ImageAssets.messageCircleIc,
              width: AppSize.s28,
              height: AppSize.s28,
            ),
            label: 'Chat'),
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.botIc,
              width: AppSize.s28,
              height: AppSize.s28,
            ),
            label: 'Bot'),
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.addIc,
              width: AppSize.s28,
              height: AppSize.s28,
            ),
            label: 'Create'),
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.knowledgeIc,
              width: AppSize.s28,
              height: AppSize.s28,
            ),
            label: 'Knowledge'),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
    );
  }
}
