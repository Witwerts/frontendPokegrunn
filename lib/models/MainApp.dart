import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/PageNavigator.dart';
import 'package:pokegrunn/pages/EmptyPage.dart';
import 'package:pokegrunn/pages/HomePage.dart';
import 'package:pokegrunn/views/NavigationView.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  //navigation
  //current user
  //settings (theme...)
  static const Color color1 = Color(0xFFF0F0F0);
  static const Color color2 = Color(0xFF4B646B);
  static const Color color3 = Color(0xFF104E5B);
  static const Color color4 = Color.fromARGB(255, 53, 79, 82);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NavigationController navController = Provider.of<NavigationController>(context);
    Map<int, PageNavigator> navigators = navController.navigators;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 132, 169, 140)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            ...navigators.values.toList(),
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

