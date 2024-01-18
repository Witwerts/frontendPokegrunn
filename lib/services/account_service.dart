import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    required this.email,
  });

  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String email;
}

class AccountService {
  const AccountService(this.apiEnpoint, this.storage);

  final String apiEnpoint;
  final FlutterSecureStorage storage;

  void saveUser(String username) async {
    await storage.write(key: "username", value: username);
  }

  void clearUser() async {
    await storage.delete(key: "username");
  }

  Future<String?>? readUser() async {
    String? username = await storage.read(key: "username");
    
    return username;
  }

  Future<UserModel> fetchUser(String username) async {
    var uri = Uri.parse("http://$apiEnpoint/api/user/$username");
    http.Response response;
    try {
      response = await http.get(uri);
    } catch (e) {
      throw Exception('Failed to connect to server $apiEnpoint');
    }

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body) as dynamic;

      return UserModel(
        id:body['id'],
        username: body['username'],
        firstName: body['first_name'],
        lastName: body['last_name'],
        email: body['email']
        );
    } else {
      throw Exception('Failed to load user');
    }
  }
}