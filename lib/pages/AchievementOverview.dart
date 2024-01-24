import 'package:flutter/material.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import '../models/NavigationPage.dart';

class Achievementoverview extends NavigationPage {
  const Achievementoverview({super.key, required this.achievement});
  final AchievementModel achievement;

  @override
  String get routePath => "/dashboard";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => AchievementOverviewPageState();
}

class AchievementOverviewPageState
    extends NavigationPageState<Achievementoverview> {
  @override
  Widget build(BuildContext context) {
    AchievementModel achievement = widget.achievement;
    return Container(
        color: MainApp.color1,
        padding: EdgeInsets.zero,
        child: Stack(children: [
          Titlebar(
            title: "${achievement.title}",
            barHeight: 80,
          ),
        ]));
  }
}
