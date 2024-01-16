import 'package:flutter/material.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage();

  bool get showNavigation => true;

  String get routePath => "";
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => NavigationPageState();
}
