import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPage.dart';
import 'package:pokegrunn/pages/EmptyPage.dart';
import 'package:pokegrunn/pages/HomePage.dart';
import 'package:provider/provider.dart';

class PageNavigator extends StatefulWidget {
  final NavigationCategory tabCategory;
  final bool showNavigation;
  late GlobalKey<NavigatorState> navKey;

  bool active = false;
  NavigationPage? currentPage;

  Map<String, NavigationPage> loadedPages = {};

  PageNavigator({
    required this.tabCategory,
    this.showNavigation = false,
    this.active = false,
  }){
    navKey = GlobalKey<NavigatorState>();

    print("navigatie key: ${navKey}");
  }
  
  @override
  State<StatefulWidget> createState() => PageNavigatorState();
}

class PageNavigatorState extends State<PageNavigator> {
  @override
  Widget build(BuildContext context) {
    NavigationController navController = Provider.of<NavigationController>(context);

    return Navigator(
      key: widget.navKey,
      initialRoute: widget.tabCategory.url,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        String route = settings.name ?? '/notfound';
        NavigationPage page = EmptyPage();

        if(widget.loadedPages.containsKey(route)){
          page = widget.loadedPages[route]!;
        }
        else {
          page = navController.getPage(route) ?? EmptyPage();
        }

        builder = (BuildContext _) => (
          Visibility(
            visible: widget.active,
            child: page,
          )
        );

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}