import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import "dart:async";
// import 'package:http/http.dart' as http;
// import "dart:convert";

import 'package:flutterpoc/Framework/framework.dart';
import 'package:flutterpoc/constants.dart' as constants;
import 'package:flutterpoc/Dashboard/Widgets/index.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _MyAppState();
}

class _MyAppState extends State<Dashboard> {
  List<Widget> data = [];
  List<String> dataOrder = constants.defaultWidgetOrder;
  int i = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String activeUser = prefs.getString('activeUser') ?? "";
    dataOrder = prefs.getStringList('${activeUser}_dataOrder') ?? dataOrder;
    createWidgetList(dataOrder);
  }

  void createWidgetList(List<String> dataOrder) {
    List<Widget> newDataList = [];
    dataOrder.forEach((name) {
      if (name == 'workorders') {
        newDataList.add(const WorkOrdersWidget());
      } else if (name == 'insight') {
        newDataList.add(const InsightWidget());
      } else if (name == 'cyclecounts') {
        newDataList.add(const CycleCountsWidget());
      }
    });
    setState(() {
      data = newDataList;
    });
  }

  void reorder(int oldIndex, int newIndex) async {
    final prefs = await SharedPreferences.getInstance();
    dataOrder.insert(newIndex, dataOrder.removeAt(oldIndex));
    var activeUser = prefs.getString('activeUser');
    await prefs.setStringList('${activeUser}_dataOrder', dataOrder);
    setState(() {
      data.insert(newIndex, data.removeAt(oldIndex));
    });
  }

  @override
  Widget build(BuildContext context) {
    var body = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReorderableWrap(
            spacing: 8.0,
            runSpacing: 4.0,
            padding: const EdgeInsets.all(8),
            onReorder: reorder,
            children: data,
          ),
        ],
      ),
    );

    return Framework(element: body, title: 'Dashboard');
  }
}
