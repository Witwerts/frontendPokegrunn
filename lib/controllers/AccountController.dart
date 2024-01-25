import "dart:convert";

import "package:flutter/widgets.dart";
import "package:http/http.dart";
import "package:latlong2/latlong.dart";
import "package:pokegrunn/controllers/DataManager.dart";
import "package:pokegrunn/models/UserModel.dart";
import "package:pokegrunn/services/account_service.dart";
import "package:pokegrunn/services/achievement_service.dart";
import "package:pokegrunn/services/location_service.dart";

class AccountController with ChangeNotifier {
  AccountController(this.accountService, this.achievementService, this.locationService);

  String? _username;
  LatLng? _position;

  String? get username => _username;
  LatLng? get position => _position;

  UserModel? _user;
  UserModel? get user => _user;

  final AccountService accountService;
  final AchievementService achievementService;
  final LocationService locationService;

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
    LatLng? position = await locationService.getCurrent();

    await locationService.startListening(updateLocation);

    if (userData != null) {
      _username = userData.username;

      if(position != null){
        _position = position;
        locationService.currentPosition = position;
      }

      _user = userData;

      accountService.saveUser(_username!);

      return true;
    }

    notifyListeners();

    return false;
  }

  void updateLocation(LatLng pos){
    _position = pos;

    notifyListeners();
  }

  Future<bool> logout() async {
    await accountService.clearUser();

    locationService.stoplistening();

    _username = null;

    notifyListeners();

    return true;
  }


}
