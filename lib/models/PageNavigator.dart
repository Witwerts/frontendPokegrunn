import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPage.dart';
import 'package:pokegrunn/pages/EmptyPage.dart';
import 'package:provider/provider.dart';

class PageNavigator extends StatefulWidget {
  final NavigationCategory tabCategory;
  late GlobalKey<NavigatorState> navKey;

  bool active = false;
  NavigationPage? currentPage;

  Map<String, NavigationPage> loadedPages = {};

  PageNavigator({super.key, 
    required this.tabCategory,
    this.active = false,
  }){
    navKey = GlobalKey<NavigatorState>();

    print("navigatie key: $navKey");
  }
  
  @override
  State<StatefulWidget> createState() => PageNavigatorState();
}

class PageNavigatorState extends State<PageNavigator> {
  @override
  Widget build(BuildContext context) {
    NavigationController navController = Provider.of<NavigationController>(context);
    AccountController accountController = Provider.of<AccountController>(context);

    return Navigator(
      key: widget.navKey,
      initialRoute: widget.tabCategory.url,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        String route = settings.name ?? '/notfound';
        NavigationPage page = const EmptyPage();

        if(widget.loadedPages.containsKey(route)){
          page = widget.loadedPages[route]!;
        }
        else {
          page = navController.getPage(route) ?? const EmptyPage();
        }

        widget.loadedPages[route] = page;

        builder = (BuildContext _) => page;

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}