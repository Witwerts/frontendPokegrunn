import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/widgets/CarouselList.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/views/CarouselView.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import 'package:provider/provider.dart';
import '../models/NavigationPage.dart';

class HomePage extends NavigationPage {
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
    AchievementController achievementController =
        Provider.of<AchievementController>(context);
    List<AchievementModel>? achievements = achievementController.achievements;

    print("achievements to show... ${achievements?.length ?? 0}");

    return Container(
      color: MainApp.color1,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Titlebar(
            title: "Dashboard",
            barHeight: 80,
            showBack: true,
          ),
          Container(
            padding: EdgeInsets.only(top: 80, bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselView(
                  height: 507,
                  items: [
                    CarouselList(
                      title: 'Reeds behaald',
                      items: achievements?.sublist(0, min(5, achievements.length)) ?? [],
                      icon: 'src/icons/map.svg',
                    ),
                    CarouselList(
                      title: 'In de buurt',
                      items: achievements?.sublist(0, min(5, achievements.length)) ?? [],
                      icon: 'src/icons/map.svg',
                    ),
                  ]
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
