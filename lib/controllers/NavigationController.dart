import 'package:flutter/material.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPage.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/pages/AccountPage.dart';
import 'package:pokegrunn/pages/DashboardPage.dart';
import 'package:pokegrunn/pages/HomePage.dart';
import 'package:pokegrunn/pages/MapPage.dart';
import 'package:pokegrunn/pages/SearchPage.dart';

class NavigationController extends ChangeNotifier {
  int tabIndex = 0;
  List<NavigationCategory> tabCategories = NavigationCategory.all;

  Map<int, PageNavigator> navigators = {};

  Map<String, NavigationPage> pages = {
    '/': HomePage(),
    '/dashboard': DashboardPage(),
    '/search': SearchPage(),
    '/map': MapPage(),
    '/account': AccountPage(),
    '/achievements': HomePage(),
  };

  NavigationController(){
    tabIndex = 0;

    navigators[-1] = PageNavigator(tabCategory: NavigationCategory.none, showNavigation: false);

    for(var tIndex = 0; tIndex < tabCategories.length; tIndex++){
      NavigationCategory cat = tabCategories[tIndex];

      navigators[tIndex] = PageNavigator(tabCategory: cat, showNavigation: true, active: tIndex == tabIndex);
    }
  }

  Map<int, Map<String, NavigationPage>> loadedPages = {};
  PageNavigator? get activeNavigator => navigators[tabIndex];

  bool gotoPage(int tabIndex, String route){
    print("goto tab $tabIndex");

    if(!navigators.containsKey(tabIndex)){
      return false;
    }

    PageNavigator newNavigator = navigators[tabIndex]!;

    if(newNavigator.currentPage == null || (newNavigator.currentPage != null && newNavigator.currentPage?.routePath != route)){
      newNavigator.navKey.currentState?.pushNamed(route);

      print("switch!");

      navigators[this.tabIndex]!.active = false;

      this.tabIndex = tabIndex;

      navigators[tabIndex]!.active = true;

      notifyListeners();

      return true;
    }

    return false;
  }

  NavigationPage? getPage(String route){
    if(pages.containsKey(route)){
      print("page found!");

      return pages[route];
    }
    
    return null;
  }
}