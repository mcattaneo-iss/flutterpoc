import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  const CustomAppBar({Key? key, required this.height, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toString()),
      backgroundColor: const Color(0xFF212121),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
