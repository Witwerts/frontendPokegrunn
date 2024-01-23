import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:provider/provider.dart';
import '../models/NavigationPage.dart';

class AccountPage extends NavigationPage  {
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
    AccountController accountController = Provider.of<AccountController>(context, listen: false);
    NavigationController navController = Provider.of<NavigationController>(context, listen: false);

    bool result = await accountController.logout();

    if(result){
      for(PageNavigator navigator in navController.navigators.values){
        navController.resetTab(navigator.tabCategory.tabIndex);
      }

      navController.switchTab(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    AccountController accountController = Provider.of<AccountController>(context);
    NavigationController navController = Provider.of<NavigationController>(context);

    return Container(
      color: const Color.fromARGB(255, 240, 240, 240),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => logout(),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size.fromHeight(0),
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "uitloggen",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}