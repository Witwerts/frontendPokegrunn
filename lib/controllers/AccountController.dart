import "dart:convert";

import "package:flutter/widgets.dart";
import "package:http/http.dart" as http;
import "package:pokegrunn/services/account_service.dart";

class AccountController with ChangeNotifier {
  AccountController(this.accountService);

  String requestedUrl = "/";

  String _username = "";
  String get username => _username;

  final AccountService accountService;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> loadUser() async {
    try {
    var readUsername = await accountService.readUser();

    if (readUsername != null) {
      _username = readUsername;
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    } catch (e) {
      throw Exception(e);
    }
  }

  // REWRITE
  Future<bool> login(String username) async {
    var uri = Uri.parse("http://${accountService.apiEnpoint}/api/user/$username");
    var client = http.Client();
    try {
      var response = await client.get(uri);
      Map<String, dynamic> decodedResponse = json.decode(response.body);

      String decodedUsername = decodedResponse['username'];
      _username = decodedUsername;
      accountService.saveUser(decodedUsername);
      _isLoggedIn = true;

      return true;
    } catch (e) {
      client.close();
    }

    _isLoggedIn = false;

    return false;
  }
}