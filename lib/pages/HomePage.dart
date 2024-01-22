import 'package:flutter/material.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import '../models/NavigationPage.dart';

class HomePage extends NavigationPage  {
  const HomePage({super.key});

  @override
  String get routePath => "/";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => HomePageState();
}

class HomePageState extends NavigationPageState {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MainApp.color2,  
      padding: EdgeInsets.zero,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Name: Pieter'),
        ],
      ),
    );
  }
}