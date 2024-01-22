import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:pokegrunn/controllers/DataManager.dart';
import 'dart:convert' as convert;

import 'package:pokegrunn/models/UserModel.dart';

class AchievementService {
  const AchievementService(this.apiEnpoint, this.storage);

  final String apiEnpoint;
  final FlutterSecureStorage storage;

  Future<Response?> registerAchievementToUser(
      String user, String achievement) async {
    Response? response = await DataManager.postResult(
        "$apiEnpoint/register-achievement",
        {"username": user, "achievement_code": achievement},
        5000);

    return response;
  }
}
