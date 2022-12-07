import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterpoc/Framework/framework.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _MyAppState();
}

class _MyAppState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('activeUser') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var body = ListView(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.display_settings),
            title: const Text('Dashboard Widgets'),
            trailing: const Icon(Icons.arrow_right),
            onTap: () =>
                {Navigator.of(context).pushNamed('/settings/dashboard')},
          ),
        ),
      ],
    );

    return Framework(element: body, title: 'Settings');
  }
}
