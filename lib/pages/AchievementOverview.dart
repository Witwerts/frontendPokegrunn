import 'package:flutter/material.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import '../models/NavigationPage.dart';

class Achievementoverview extends NavigationPage {
  const Achievementoverview({super.key});
}

class SearchPageState extends NavigationPageState {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MainApp.color1,
        padding: EdgeInsets.zero,
        child: Stack(children: [
          Titlebar(
            title: "Achievement",
            barHeight: 80,
          ),
        ]));
  }
}
