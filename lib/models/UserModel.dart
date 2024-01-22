class UserModel {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    username = json["username"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
  }
}