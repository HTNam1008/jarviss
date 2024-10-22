import 'package:flutter/material.dart';

class CustomHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? centerWidget; // Widget ở giữa (như Dropdown)
  final List<Widget>? actions; // Nút hoặc icon ở bên phải
  final Widget? leading; // Nút bên trái (ví dụ: Icon menu)
  final bool centerTitle;
  const CustomHeaderBar({
    this.centerWidget,
    this.actions,
    this.leading,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal.shade300,
      elevation: 0,
      leading: leading ??
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
      title: centerWidget,
      centerTitle: centerTitle,
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
