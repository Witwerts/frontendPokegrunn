import 'package:flutter/material.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import '../models/NavigationPage.dart';

class DashboardPage extends NavigationPage  {
  const DashboardPage({super.key});

  @override
  String get routePath => "/dashboard";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => DashboardPageState();
}

class DashboardPageState extends NavigationPageState {

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