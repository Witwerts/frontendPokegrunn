import "dart:convert";

import "package:flutter/widgets.dart";
import "package:http/http.dart" as http;
import "package:http/http.dart";
import "package:pokegrunn/controllers/DataManager.dart";
import "package:pokegrunn/models/AchievementModel.dart";
import "package:pokegrunn/models/UserModel.dart";
import "package:pokegrunn/services/account_service.dart";
import "package:pokegrunn/services/achievement_service.dart";

class AchievementController with ChangeNotifier {
  AchievementController(this.accountService, this.achievementService);

  List<AchievementModel> _achievements = [];
  List<AchievementModel> get achievements => _achievements;

  final AccountService accountService;
  final AchievementService achievementService;

  void loadAchievements() async {
    List<AchievementModel>? achievementList = await achievementService.fetchAchievements();

    if(achievementList != null){
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
      print(response.statusCode == 201);
      return (response.statusCode == 201, response.body);
    }
    return (false, " Response niet gevonden");
  }
}