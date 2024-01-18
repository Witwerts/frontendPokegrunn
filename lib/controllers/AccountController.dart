import "package:flutter/widgets.dart";
import "package:pokegrunn/services/account_service.dart";

class AccountController with ChangeNotifier {
  AccountController(this.accountService);

  String requestedUrl = "/";

  final AccountService accountService;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // REWRITE
  bool login(String username) {
    if (_isLoggedIn) {
      return false;
    }

    // Check if user exists
    try {
      accountService.fetchUser(username).then((value) => null);
    } catch (e) {
      throw Exception(e);
    }
    accountService.saveUser(username);
    //_isLoggedIn = true;

    notifyListeners();

    return true;
  }

  // REWRITE
  bool logout() {
    if (!_isLoggedIn) {
      return false;
    }

    accountService.clearUser();
    _isLoggedIn = false;

    notifyListeners();

    return true;
  }
}