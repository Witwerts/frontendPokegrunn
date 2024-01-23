import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:pokegrunn/controllers/DataManager.dart';
import 'package:pokegrunn/models/AchievementModel.dart';
import 'dart:convert' as convert;

import 'package:pokegrunn/models/UserModel.dart';

class AchievementService {
  const AchievementService(this.apiEnpoint);

  final String apiEnpoint;

  Future<Response?> registerAchievementToUser(
      String user, String achievement) async {
    Response? response = await DataManager.postResult(
        "$apiEnpoint/register-achievement",
        {"username": user, "achievement_code": achievement},
        5000);

    return response;
  }

  Future<List<AchievementModel>?> fetchAchievements() async {
    Response? response = await DataManager.getResponse("$apiEnpoint/achievements");

    print("read achievements1");

    if (response != null && response.statusCode == 200) {
      print("read achievements2");

      List<dynamic>? body = DataManager.convertData(response) as List<dynamic>?;

      if(body != null){
        List<AchievementModel> achList = body!.map((ach) => AchievementModel.fromJson(ach)).toList();

        return achList;
      }
    }

    return null;
  }
}
