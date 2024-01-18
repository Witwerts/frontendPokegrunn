import 'package:flutter/material.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  bool get showNavigation => true;

  String get routePath => "";
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => NavigationPageState();
}