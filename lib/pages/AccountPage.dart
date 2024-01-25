import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/pages/UserOverview.dart';
import 'package:pokegrunn/views/BoxContainer.dart';
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
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  accountController.user?.username ?? "",
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
              BoxContainer(
                  margin: EdgeInsets.all(4),
                  child: Column(children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8),
                              child: Icon(
                                Icons.supervisor_account_sharp,
                                size: 35,
                              )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 5),
                              child: Text(
                                'Vrienden',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Divider(height: 16),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 4),
                                child: Column(
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        height: 80,
                                        margin: EdgeInsets.zero,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 6.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            width: 1.0,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6.0)),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blueGrey
                                                      .withOpacity(0.2),
                                                ),
                                                child: ClipOval(
                                                  child: OverflowBox(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Align(
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        8),
                                                            child: Icon(
                                                              Icons
                                                                  .account_circle,
                                                              size: 60,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //Hier kloten
                                            Expanded(
                                              flex:
                                                  6, // Flex voor de rode container
                                              child: GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserOverview())),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 4.0),
                                                  width: double.infinity,
                                                  height: double
                                                      .infinity, // Hoogte wordt automatisch verdeeld
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Albert Witwerts',
                                                        style: const TextStyle(
                                                            fontSize: 27.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.8,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color:
                                                                MainApp.color3),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],

                                          //children: widget.items.map((item) {
                                          //bool isLast = widget.items.indexOf(item) == (widget.items.length-1);

                                          //print(widget.items.indexOf(item));
                                          //print(isLast);

                                          //return CarouselListItem(item, EdgeInsets.only(bottom: !isLast ? 4.0 : 0.0));
                                          //}).toList(),
                                        )),
                                  ],
                                ))
                          ],
                        )
                      ],
                    )
                  ]))
            ]),
          ),
          Divider(),
          Expanded(
            child: Container(
              margin:
                  EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 100),
              padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () => logout(),
                style: ElevatedButton.styleFrom(
                  primary: MainApp.color2,
                  onPrimary: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
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
          )
        ]));
  }
}
