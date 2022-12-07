import 'package:flutter/material.dart';

class BoardHeader extends StatelessWidget {
  final String title;

  const BoardHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
