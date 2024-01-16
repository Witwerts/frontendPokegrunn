import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/widgets/NavItem.dart';
import 'package:provider/provider.dart';

import '../models/MainApp.dart';

class NavigationView extends StatelessWidget {
  bool visible = false;
  
  @override
  Widget build(BuildContext context) {
    NavigationController navController = Provider.of<NavigationController>(context);

    List<NavigationCategory> navCategories = NavigationCategory.all;
    List<Widget> buttons = <Widget>[];

    for(var cIndex = 0; cIndex < navCategories.length; cIndex++){
      NavigationCategory cat = navCategories.elementAt(cIndex);

      Widget button = NavItem(cat.svgIcon, navController.activeNavigator?.tabCategory == cat, onTap: () => navController.gotoPage(cIndex, cat.url));

      buttons.add(button);
    }

    return Visibility(
      visible: navController.activeNavigator?.showNavigation ?? false,
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: 70,
            padding: EdgeInsets.zero,
            color: MainApp.color3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            ),
          ),
        ),
      ),
    );
  }
}