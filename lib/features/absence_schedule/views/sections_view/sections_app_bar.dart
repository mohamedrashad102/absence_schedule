import 'package:flutter/material.dart';

class SectionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SectionsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'المجموعات',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
