import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:async";

import 'package:flutterpoc/constants.dart' as constants;
import 'package:flutterpoc/Framework/framework.dart';

class DashboardSettings extends StatefulWidget {
  const DashboardSettings({super.key});

  @override
  State<DashboardSettings> createState() => _MyAppState();
}

class _MyAppState extends State<DashboardSettings> {
  List<String> dataOrder = constants.defaultWidgetOrder;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String activeUser = prefs.getString('activeUser') ?? "";
    setState(() {
      dataOrder = prefs.getStringList('${activeUser}_dataOrder') ?? dataOrder;
    });
  }

  void toggleWidget(String identifier, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> newOrder = dataOrder;
    if (newOrder.contains(identifier) && !value) {
      newOrder.removeAt(newOrder.indexOf(identifier));
    } else if (!newOrder.contains(identifier) && value) {
      dataOrder.add(identifier);
    }

    String activeUser = prefs.getString('activeUser') ?? "";
    await prefs.setStringList('${activeUser}_dataOrder', newOrder);

    setState(() {
      dataOrder = newOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    var body = ListView(
      children: [
        Card(
          child: ListTile(
            title: Text('Work Orders'),
            trailing: Switch(
              value: dataOrder.contains('workorders'),
              onChanged: (bool value) {
                toggleWidget('workorders', value);
              },
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Insight'),
            trailing: Switch(
              value: dataOrder.contains('insight'),
              onChanged: (bool value) {
                toggleWidget('insight', value);
              },
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Cycle Clunts'),
            trailing: Switch(
              value: dataOrder.contains('cyclecounts'),
              onChanged: (bool value) {
                toggleWidget('cyclecounts', value);
              },
            ),
          ),
        ),
      ],
    );
    return Framework(element: body, title: 'Dashboard Widgets');
  }
}
