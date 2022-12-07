import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterpoc/Framework/framework.dart';
import 'package:flutterpoc/constants.dart' as constants;

class WorkOrders extends StatefulWidget {
  const WorkOrders({super.key});

  @override
  State<WorkOrders> createState() => _MyAppState();
}

class _MyAppState extends State<WorkOrders> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String activeUser = prefs.getString('activeUser') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var body = Container();

    return Framework(element: body, title: 'Work Orders');
  }
}
