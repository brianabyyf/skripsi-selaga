import 'dart:convert';

class RegisterUserModel {
  String name;
  String email;
  String phone;
  String password;

  RegisterUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory RegisterUserModel.fromRawJson(String str) =>
      RegisterUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      };
}
