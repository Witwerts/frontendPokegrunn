import 'package:flutter/material.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import '../models/NavigationPage.dart';

class DashboardPage extends NavigationPage  {
  DashboardPage();

  @override
  String get routePath => "/dashboard";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => DashboardPageState();
}

class DashboardPageState extends NavigationPageState {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MainApp.color1,
      padding: EdgeInsets.zero,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('HALLO RUTGER!'),
        ],
      ),
    );
  }
}