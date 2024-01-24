import 'package:flutter/material.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/pages/AchievementOverview.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import '../models/NavigationPage.dart';

class SearchPage extends NavigationPage {
  const SearchPage({super.key});

  @override
  String get routePath => "/search";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => SearchPageState();
}

class SearchPageState extends NavigationPageState {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MainApp.color1,
        padding: EdgeInsets.zero,
        child: Stack(children: [
          Titlebar(
            title: "Overzicht van de achievements",
            barHeight: 80,
          ),
          Container(
            padding: EdgeInsets.only(top: 80, bottom: 80),
          )
        ]));
  }
}
