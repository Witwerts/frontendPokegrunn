import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/widgets/NavItem.dart';
import 'package:provider/provider.dart';


class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navController = Provider.of<NavigationController>(context);

    List<NavigationCategory> navCategories = NavigationCategory.all;
    List<Widget> buttons = <Widget>[];

    for(var cIndex = 0; cIndex < navCategories.length; cIndex++){
      NavigationCategory cat = navCategories.elementAt(cIndex);

      Widget button = NavItem(cat.svgIcon, cat.title, navController.activeNavigator?.tabCategory == cat, onTap: () => navController.gotoPage(cIndex, cat.url));

      buttons.add(button);
    }

    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.4),
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          ),
        ),
      ),
    );
  }
}