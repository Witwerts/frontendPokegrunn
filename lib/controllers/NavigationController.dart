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
    'qrscan': const QRScanPage(),
  };

  NavigationController() {
    tabIndex = -1;

    for (var tIndex = 0; tIndex < tabCategories.length; tIndex++) {
      NavigationCategory cat = tabCategories[tIndex];

      navigators[tIndex] =
          PageNavigator(tabCategory: cat, active: tIndex == tabIndex);
    }

    navigators[navigators.length] =
        PageNavigator(tabCategory: NavigationCategory.none);
  }

  Map<int, Map<String, NavigationPage>> loadedPages = {};
  PageNavigator? get activeNavigator => navigators[tabIndex];

  bool switchTab(int? tabIndex) {
    tabIndex = tabIndex ?? this.tabIndex;

    print("switch from tab ${this.tabIndex} to ${tabIndex}");

    if (tabIndex >= navigators.length) {
      return false;
    }

    this.tabIndex = tabIndex;

    notifyListeners();

    return true;
  }

  bool gotoPage(String route, [int? tabIndex, bool replace = false]) {
    tabIndex = tabIndex ?? this.tabIndex;

    if (!navigators.containsKey(tabIndex)) {
      return false;
    }

    if (!navigators.containsKey(tabIndex)) {
      return false;
    }

    GlobalKey<NavigatorState>? navKey = navigators[tabIndex]!.navKey;

    if (tabIndex != this.tabIndex) {
      switchTab(tabIndex);
    }

    if (replace) {
      navKey.currentState?.popAndPushNamed(route);
    } else {
      navKey.currentState?.pushNamed(route);
    }

    notifyListeners();

    return true;
  }

  NavigationPage? getPage(String route) {
    if (pages.containsKey(route)) {
      return pages[route];
    }

    return null;
  }

  bool urlExists(String url) {
    return pages.containsKey(url);
  }
}
