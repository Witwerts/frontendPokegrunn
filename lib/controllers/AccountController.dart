import "dart:convert";

import "package:flutter/widgets.dart";
import "package:http/http.dart" as http;
import "package:pokegrunn/controllers/DataManager.dart";
import "package:pokegrunn/models/UserModel.dart";
import "package:pokegrunn/services/account_service.dart";

class AccountController with ChangeNotifier {
  AccountController(this.accountService);

  String? _username;
  String? get username => _username;

  final AccountService accountService;

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

    if(userData != null){
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
}