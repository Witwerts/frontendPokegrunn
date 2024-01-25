import "dart:convert";
import "dart:math";

import "package:flutter/widgets.dart";
import "package:http/http.dart" as http;
import "package:http/http.dart";
import "package:latlong2/latlong.dart";
import "package:pokegrunn/controllers/DataManager.dart";
import "package:pokegrunn/models/AchievementModel.dart";
import "package:pokegrunn/models/UserModel.dart";
import "package:pokegrunn/services/account_service.dart";
import "package:pokegrunn/services/achievement_service.dart";
import "package:pokegrunn/services/location_service.dart";

class AchievementController with ChangeNotifier {
  AchievementController(this.accountService, this.achievementService, this.locationService);

  List<AchievementModel> _achievements = [];
  List<AchievementModel> get achievements => _achievements;

  final AccountService accountService;
  final AchievementService achievementService;
  final LocationService locationService;

  void loadAchievements() async {
    List<AchievementModel>? achievementList =
        await achievementService.fetchAll();

    if (achievementList != null) {
      _achievements = achievementList;

      print("${_achievements.length} found");

      notifyListeners();
    }
  }

  Future<(bool, String)> registerAchievementToUser(
      String user, String achievement) async {
    Response? response =
        await achievementService.registerAchievementToUser(user, achievement);

    if (response != null) {
      return (response.statusCode == 201, response.body);
    }
    return (false, " Response niet gevonden");
  }

  Future<List<AchievementModel>> getClosest(int max) async {
    LatLng? currentPos = locationService.currentPosition;

    if(currentPos == null){
      return [];
    }

    List<AchievementModel> achievements = await achievementService.fetchAll({
      "max": max.toString(),
      "latitude": currentPos.latitude.toString(),
      "longitude": currentPos.longitude.toString()
    }) ?? [];

    return achievements.sublist(0, min(max, achievements.length));
  }

  Future<List<AchievementModel>> getRecent(String? username, int max) async {
    LatLng? currentPos = locationService.currentPosition;

    if(currentPos == null || username == null){
      return [];
    }

    List<AchievementModel> achievements = await achievementService.fetchUser({
      "username": username,
    }) ?? [];

    achievements.sort((a, b) => b.id!.compareTo(a.id!));

    return achievements.sublist(0, min(max, achievements.length));
  }
}
