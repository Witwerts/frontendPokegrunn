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
import 'package:pokegrunn/views/BarcodeScannerView.dart';

class NavigationController extends ChangeNotifier {
  int tabIndex = -1;
  List<NavigationCategory> tabCategories = NavigationCategory.all;
  bool visibility = true;

  Map<int, PageNavigator> navigators = {};

  Map<String, Function> pages = {
    'home': () => const HomePage(),
    'dashboard': () => const DashboardPage(),
    'search': () => const SearchPage(),
    'map': () => const MapPage(),
    'account': () => const AccountPage(),
    'achievements': () => const HomePage(),
    'login': () => const LoginPage(),
    'qrscan': () => const BarcodeScannerView(),
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

    PageNavigator? navigator = getNavigator(tabIndex);

    visibility = navigator?.currentPage?.showNavigation ?? false;

    notifyListeners();

    return true;
  }

  PageNavigator? getNavigator(int tabIndex){
    if (tabIndex >= navigators.length) {
      return null;
    }

    return navigators[tabIndex < 0 ? (navigators.length + tabIndex) : tabIndex]!;
  }

  bool resetTab(int tabIndex){
    if (tabIndex >= navigators.length) {
      return false;
    }

    PageNavigator? navigator = navigators[tabIndex];

    if(navigator == null){
      return false;
    }

    navigator.reset();

    notifyListeners();

    return true;
  }

  void toggleVisibility(bool visible){
    print("update visible?");

    visibility = visible;
    notifyListeners();
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
    NavigationPage? page = this.getPage(route);
    PageNavigator? navigator = getNavigator(tabIndex);

    if (tabIndex != this.tabIndex) {
      switchTab(tabIndex);
    }

    if (replace) {
      navKey.currentState?.popAndPushNamed(route, );
    } else {
      navKey.currentState?.pushNamed(route).then((result){
      });
    }

    notifyListeners();

    return true;
  }

  void pageClosed(NavigationPage prevPage){
    print("prev page: ");
    print(prevPage.runtimeType);
  }

  NavigationPage? getPage(String route) {
    if (pages.containsKey(route)) {
      return pages[route]!();
    }

    return null;
  }

  bool urlExists(String url) {
    return pages.containsKey(url);
  }
}
