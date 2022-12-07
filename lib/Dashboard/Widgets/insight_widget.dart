import 'package:flutter/material.dart';

class InsightWidget extends StatelessWidget {
  const InsightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: GestureDetector(
        onTap: () => {
          {Navigator.of(context).pushNamed('/insight')},
        },
        child: Card(
          child: Image.asset('assets/images/Insight.png'),
        ),
      ),
    );
  }
}
