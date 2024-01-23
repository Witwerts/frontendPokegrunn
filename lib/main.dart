import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/AchievementController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/services/account_service.dart';
import 'package:pokegrunn/services/achievement_service.dart';
import 'package:provider/provider.dart';
import 'package:pokegrunn/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NavigationController navController = NavigationController();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  AccountService accountService = AccountService(pokeGrunnApiEndpoint, storage);
  AchievementService achievementService = AchievementService(pokeGrunnApiEndpoint);

  AccountController accountController = AccountController(accountService);
  AchievementController achievementController = AchievementController(accountService, achievementService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => navController),
        ChangeNotifierProvider(create: (context) => accountController),
        ChangeNotifierProvider(create: (context) => achievementController),
      ],
      child: const MainApp(),
    ),
  );
}