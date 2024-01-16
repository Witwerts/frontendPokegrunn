import 'package:flutter/material.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import '../models/NavigationPage.dart';

class AccountPage extends NavigationPage  {
  AccountPage();

  @override
  String get routePath => "/account";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => AccountPageState();
}

class AccountPageState extends NavigationPageState {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 240, 240, 240),
      padding: EdgeInsets.zero,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Name: Klaas'),
        ],
      ),
    );
  }
}