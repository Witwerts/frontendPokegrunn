import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/models/UserModel.dart';
import 'package:pokegrunn/pages/UserOverview.dart';
import 'package:pokegrunn/views/BoxContainer.dart';
import 'package:pokegrunn/widgets/CarouselListItem.dart';
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

    List<UserModel> friends = accountController.friends;

    if(accountController.isLoggedIn){
      friends.remove(accountController.user);
    }

    return Container(
      color: MainApp.color1,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          const Titlebar(
            title: "Account",
            barHeight: 80,
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            padding: EdgeInsets.zero,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Text(
                          accountController.user?.username ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                            height: 1.0
                          ),
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
                              "${accountController.points} punten",
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                height: 1.0,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
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
                              "Friends",
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
                              children: friends.map((friend) {
                                bool isLast = friends.indexOf(friend) == (friends.length-1);

                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserOverview(
                                        user: friend,
                                      ),
                                    ),
                                  ),
                                  child: BoxContainer(
                                    radius: const BorderRadius.all(Radius.circular(6)),
                                    margin: EdgeInsets.zero,
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
                                            friend.username ?? '',
                                            style: const TextStyle(
                                              fontSize: 27.0,
                                              fontWeight: FontWeight.w500,
                                              height: 1.8,
                                              overflow: TextOverflow.ellipsis,
                                              color:MainApp.color3),
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
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                      padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        onPressed: () => logout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainApp.color2,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
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
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
