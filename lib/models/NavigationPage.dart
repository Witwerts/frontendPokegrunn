import 'package:flutter/material.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  String get routePath => "";
  bool get showNavigation => true;

  @override
  NavigationPageState createState() => NavigationPageState();
}