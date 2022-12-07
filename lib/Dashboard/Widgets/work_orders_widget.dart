import 'package:flutter/material.dart';

class WorkOrdersWidget extends StatelessWidget {
  const WorkOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: GestureDetector(
        onTap: () => {
          {Navigator.of(context).pushNamed('/work_orders')},
        },
        child: Card(
          child: Image.asset('assets/images/WorkOrder.png'),
        ),
      ),
    );
  }
}
