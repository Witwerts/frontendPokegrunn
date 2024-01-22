import "dart:convert";

import "package:flutter/widgets.dart";
import "package:http/http.dart";
import "package:pokegrunn/controllers/DataManager.dart";
import "package:pokegrunn/models/UserModel.dart";
import "package:pokegrunn/services/account_service.dart";
import "package:pokegrunn/services/achievement_service.dart";

class AccountController with ChangeNotifier {
  AccountController(this.accountService, this.achievementService);

  String? _username;
  String? get username => _username;

  final AccountService accountService;
  final AchievementService achievementService;

  bool get isLoggedIn => username != null;

  Future<bool> loadUser() async {
    try {
      var readUsername = await accountService.readUser();

      if (readUsername != null) {
        await login(readUsername);
      }
    } catch (e) {
      throw Exception(e);
    }

    return isLoggedIn;
  }

  Future<bool> login(String username) async {
    UserModel? userData = await accountService.fetchUser(username);

    if (userData != null) {
      _username = userData.username;

      accountService.saveUser(_username!);

      return true;
    }

    return false;
  }

  Future<bool> logout() async {
    await accountService.clearUser();

    _username = null;

    return true;
  }

  Future<(bool, String)> registerAchievementToUser(
      String user, String achievement) async {
    Response? response =
        await achievementService.registerAchievementToUser(user, achievement);

    if (response != null) {
      print(response.statusCode == 201);
      return (response.statusCode == 201, response.body);
    }
    return (false, " Response niet gevonden");
  }
}
