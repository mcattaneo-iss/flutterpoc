import 'package:flutter/material.dart';

class BoardCard extends StatelessWidget {
  final String title;

  const BoardCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(title),
    );
  }
}
