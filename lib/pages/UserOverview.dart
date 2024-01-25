import 'package:flutter/material.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/views/BoxContainer.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import '../models/NavigationPage.dart';

class UserOverview extends NavigationPage {
  const UserOverview({super.key});

  @override
  String get routePath => "/dashboard";

  @override
  bool get loginNeeded => true;

  @override
  NavigationPageState createState() => AchievementOverviewPageState();
}

class AchievementOverviewPageState extends NavigationPageState<UserOverview> {
  @override
  Widget build(BuildContext context) {
    return BoxContainer(
        padding: EdgeInsets.zero,
        child: Stack(children: [
          Titlebar(
            title: "Albert Witwer",
            barHeight: 80,
            showBack: true,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: double.infinity,
                height: 460,
                child: Column(
                  children: [
                    Container(
                      child: Icon(
                        Icons.account_circle,
                        size: 150,
                      ),
                    ),
                    Text(
                      'Punten: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    BoxContainer(
                      margin: EdgeInsets.all(4),
                      child: Column(children: [
                        Stack(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  child: Text(
                                    'Recent behaalde achievements:',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Divider(height: 16),
                                Column(children: [
                                  Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      width: double.infinity,
                                                      height: 60,
                                                      margin: EdgeInsets.zero,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .blueGrey
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                              child: ClipOval(
                                                                child:
                                                                    OverflowBox(
                                                                  child:
                                                                      Container(
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            0.0),
                                                                    child:
                                                                        Align(
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                                                          child: Icon(
                                                                            Icons.account_circle,
                                                                            size:
                                                                                60,
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
                                                            child:
                                                                GestureDetector(
                                                              onTap: () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              UserOverview())),
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5.0,
                                                                    vertical:
                                                                        4.0),
                                                                width: double
                                                                    .infinity,
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
                                                                          fontSize:
                                                                              27.0,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          height:
                                                                              1.8,
                                                                          overflow: TextOverflow
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
                                ])
                              ])
                        ]),
                      ]),
                      //Hier kloten
                    )
                  ],

                  //children: widget.items.map((item) {
                  //bool isLast = widget.items.indexOf(item) == (widget.items.length-1);

                  //print(widget.items.indexOf(item));
                  //print(isLast);

                  //return CarouselListItem(item, EdgeInsets.only(bottom: !isLast ? 4.0 : 0.0));
                  //}).toList(),
                ))
          ]),
        ]));
  }
}
