import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/NavigationPage.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/pages/EmptyPage.dart';
import 'package:pokegrunn/pages/HomePage.dart';
import 'package:pokegrunn/services/account_service.dart';
import 'package:pokegrunn/views/NavigationView.dart';
import 'package:provider/provider.dart';
import 'package:pokegrunn/util.dart';

class MainApp extends StatelessWidget {
  //navigation
  //current user
  //settings (theme...)
  static const Color color1 = Color(0xFFF0F0F0);
  static const Color color2 = Color(0xFF4B646B);
  static const Color color3 = Color(0xFF104E5B);
  static const Color color4 = Color.fromARGB(255, 53, 79, 82);

  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NavigationController navController = Provider.of<NavigationController>(context);
    Map<int, PageNavigator> navigators = navController.navigators;

    int tabIndex = navController.tabIndex < 0 ? (navigators.length + navController.tabIndex) : navController.tabIndex;

    print("current tabIndex: $tabIndex");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 132, 169, 140)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: tabIndex,
              children: navigators.values.toList()
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavigationView(),
            ),
          ]
        ),
        resizeToAvoidBottomInset: false,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

