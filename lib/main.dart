import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
//Components
import 'package:flutterpoc/Login/login.dart';
import 'package:flutterpoc/Dashboard/dashboard.dart';
import 'package:flutterpoc/Settings/settings.dart';
import 'package:flutterpoc/Settings/Widgets/index.dart';
import 'package:flutterpoc/WorkOrders/work_orders.dart';
import 'package:flutterpoc/Insight/insight.dart';

void main() async {
  runApp(
    GlobalLoaderOverlay(
      child: MaterialApp(
        title: 'Flutter Proof of Concept',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF303030)),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const Login(),
          '/dashboard': (context) => const Dashboard(),
          '/work_orders': (context) => const WorkOrders(),
          '/insight': (context) => const Insight(),
          '/settings': (context) => const Settings(),
          '/settings/dashboard': (context) => const DashboardSettings(),
        },
      ),
    ),
  );
}
