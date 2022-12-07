import 'package:flutter/material.dart';
import 'appbar.dart';
import 'navbar.dart';

class Framework extends StatefulWidget {
  final String title;
  final Widget element;
  const Framework({Key? key, required this.element, required this.title})
      : super(key: key);

  @override
  State<Framework> createState() => _MyAppState();
}

class _MyAppState extends State<Framework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: CustomAppBar(
        height: 50,
        title: widget.title,
      ),
      body: widget.element,
    );
  }
}
