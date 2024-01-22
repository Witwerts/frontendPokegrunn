import 'package:flutter/material.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPage.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/pages/AccountPage.dart';
import 'package:pokegrunn/pages/DashboardPage.dart';
import 'package:pokegrunn/pages/HomePage.dart';
import 'package:pokegrunn/pages/LoginPage.dart';
import 'package:pokegrunn/pages/MapPage.dart';
import 'package:pokegrunn/pages/QRScanPage.dart';
import 'package:pokegrunn/pages/SearchPage.dart';

class NavigationController extends ChangeNotifier {
  int tabIndex = -1;
  List<NavigationCategory> tabCategories = NavigationCategory.all;

  Map<int, PageNavigator> navigators = {};

  Map<String, NavigationPage> pages = {
    'home': const HomePage(),
    'dashboard': const DashboardPage(),
    'search': const SearchPage(),
    'map': const MapPage(),
    'account': const AccountPage(),
    'achievements': const HomePage(),
    'login': const LoginPage(),
    '/qrscan': const QRScanPage(),
  };

  NavigationController(){
    tabIndex = 0;
    
    for(var tIndex = 0; tIndex < tabCategories.length; tIndex++){
      NavigationCategory cat = tabCategories[tIndex];

      navigators[tIndex] = PageNavigator(tabCategory: cat, showNavigation: true, active: tIndex == tabIndex);
    }

    navigators[navigators.length] = PageNavigator(tabCategory: NavigationCategory.none);
  }

  Map<int, Map<String, NavigationPage>> loadedPages = {};
  PageNavigator? get activeNavigator => navigators[tabIndex];

  bool gotoPage(int tabIndex, String route){
    print("goto tab $tabIndex");

    if (!navigators.containsKey(tabIndex)) {
      return false;
    }

    if(!navigators.containsKey(tabIndex)){
      return false;
    }

    GlobalKey<NavigatorState>? navKey = navigators[tabIndex]!.navKey;

    if(newNavigator.currentPage == null || (newNavigator.currentPage != null && newNavigator.currentPage?.routePath != route)){
      newNavigator.navKey.currentState?.pushNamed(route);

      print("switch!");

      navigators[this.tabIndex]!.active = false;

      this.tabIndex = tabIndex;

      navigators[tabIndex]!.active = true;

    notifyListeners();

    return true;
  }

  NavigationPage? getPage(String route){
    if(pages.containsKey(route)){
      print("page found!");

      return pages[route];
    }

    return null;
  }

  bool urlExists(String url) {
    return pages.containsKey(url);
  }
}
