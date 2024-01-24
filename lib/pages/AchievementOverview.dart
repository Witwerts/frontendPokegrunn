import 'package:flutter/material.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/views/BoxContainer.dart';
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
    return BoxContainer(
      padding: EdgeInsets.zero,
      child: Stack(children: [
        Titlebar(
          title: "${achievement.title}",
          barHeight: 80,
          showBack: true,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: double.infinity,
              height: 460,
              child: Column(children: [
                Container(
                    child: Image.network('${achievement.image}'),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 5.0,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0)),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.calendar_month_rounded),
                      Text('${achievement.startDate} - ${achievement.endDate}',
                          style: TextStyle(fontSize: 16)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.access_time),
                      Text('${achievement.startTime} - ${achievement.endTime}',
                          style: TextStyle(fontSize: 16)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Categorie: ${achievement.category}',
                          style: TextStyle(fontSize: 16)),
                    ]),
                Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Column(children: [
                      Text('${achievement.description}'),
                      Text('Te behalen punten: ${achievement.points}',
                          style: TextStyle(fontSize: 17))
                    ]))
              ])),
        ])
      ]),
    );
  }
}
