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
  static const Color color1 = Color.fromARGB(255, 202, 210, 197);
  static const Color color2 = Color.fromARGB(255, 132, 169, 140);
  static const Color color3 = Color.fromARGB(255, 82, 121, 95);
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

