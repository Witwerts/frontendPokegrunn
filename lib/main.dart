import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:provider/provider.dart';

void main() {
  NavigationController navController = NavigationController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => navController),
      ],
      child: MainApp(),
    ),
  );
}