import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/models/UserModel.dart';
import 'package:pokegrunn/pages/AchievementOverview.dart';
import 'package:pokegrunn/views/BoxContainer.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import 'package:provider/provider.dart';
import '../models/NavigationPage.dart';

class UserOverview extends NavigationPage {
  const UserOverview({super.key, required this.user});
  final UserModel user;

  @override
  String get routePath => "/profile";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => UserOverviewPageState();
}

class UserOverviewPageState extends NavigationPageState<UserOverview> {
  int score = 0;
  List<AchievementModel> recentList = List.empty();

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) => updateData());

    super.initState();
  }

  Future<void> updateData() async {
    AchievementController achievementController = Provider.of<AchievementController>(context, listen: false);

    int score = await achievementController.getPoints(widget.user.username);
    
    List<AchievementModel> recentList = await achievementController.getRecent(widget.user.username, 5);

    if (context.mounted) {
      setState(() {
        this.score = score;
        this.recentList = recentList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AchievementController achievementController = Provider.of<AchievementController>(context);
    AccountController accountController = Provider.of<AccountController>(context);

    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      color: MainApp.color1,
      child: Stack(
        children: [
          Titlebar(
            title: widget.user.username ?? '',
            barHeight: 80,
            showBack: true,
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            padding: EdgeInsets.zero,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star_rounded,
                              size: 34,
                              color: Colors.black,
                            ),
                            Icon(
                              Icons.star_rounded,
                              size: 28,
                              color: Colors.amber,
                            ),
                          ]
                        ),
                        Text(
                          "$score punten",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            height: 1.0,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    BoxContainer(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                            child: Text(
                              "Recent behaalde achievements",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                            child: Column(
                              children: recentList.map((ach) {
                                bool isLast = recentList.indexOf(ach) == (recentList.length-1);

                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AchievementOverview(
                                        achievement: ach,
                                      ),
                                    ),
                                  ),
                                  child: BoxContainer(
                                    radius: const BorderRadius.all(Radius.circular(6)),
                                    margin: EdgeInsets.only(bottom: !isLast ? 4 : 0),
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                    borderColor: Colors.black.withOpacity(0.2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(36)),
                                              child: Container(
                                                margin: EdgeInsets.zero,
                                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                                color: const Color.fromARGB(255, 220, 220, 220),
                                                child: const Icon(
                                                  Icons.account_circle,
                                                  size: 64,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                            child: Text(
                                              ach.title ?? '',
                                              style: const TextStyle(
                                                fontSize: 27.0,
                                                fontWeight: FontWeight.w500,
                                                height: 1.8,
                                                overflow: TextOverflow.ellipsis,
                                                color:MainApp.color3
                                              ),
                                            ),
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ]
            ),
          ),
        ]
      )
    );
  }
}
