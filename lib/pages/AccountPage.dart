import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import 'package:provider/provider.dart';
import '../models/NavigationPage.dart';

class AccountPage extends NavigationPage {
  const AccountPage({super.key});

  @override
  String get routePath => "/account";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => AccountPageState();
}

class AccountPageState extends NavigationPageState {
  void logout() async {
    AccountController accountController =
        Provider.of<AccountController>(context, listen: false);
    NavigationController navController =
        Provider.of<NavigationController>(context, listen: false);

    bool result = await accountController.logout();

    if (result) {
      for (int n = 0; n < navController.navigators.length; n++) {
        navController.resetTab(n);
      }

      navController.switchTab(-1);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    AccountController accountController =
        Provider.of<AccountController>(context);
    AchievementController achievementController = 
        Provider.of<AchievementController>(context);

    return Container(
      color: MainApp.color1,  
      padding: EdgeInsets.zero,
      child: Stack(children: [
      Titlebar(
        title: "Account",
        barHeight: 80,
      ),
      Container(
        padding: EdgeInsets.only(top: 80, bottom: 80),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                accountController.user?.username??"",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${achievementController.totalPoints} punten",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: Container(
              margin: EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 30),
              padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () => logout(),
                style: ElevatedButton.styleFrom(
                  primary: MainApp.color2,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),)
          ]
        ),
      ),
    ],)
    );
  }
}
