import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:pokegrunn/controllers/DataManager.dart';
import 'dart:convert' as convert;

import 'package:pokegrunn/models/UserModel.dart';

class AccountService {
  const AccountService(this.apiEnpoint, this.storage);

  final String apiEnpoint;
  final FlutterSecureStorage storage;

  void saveUser(String username) async {
    await storage.write(key: "username", value: username);
  }

  Future<bool> clearUser() async {
    await storage.delete(key: "username");

    return true;
  }

  Future<String?>? readUser() async {
    String? username = await storage.read(key: "username");
    
    return username;
  }

  Future<UserModel?> fetchUser(String username) async {
    Response? response = await DataManager.getResponse("$apiEnpoint/user/$username");

    if (response != null && response.statusCode == 200) {
      Map<String, dynamic>? body = DataManager.convertData(response);

      if(body != null){
        return UserModel.fromJson(body);
      }
    }

    return null;
  }
}