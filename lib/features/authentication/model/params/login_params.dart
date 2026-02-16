import 'dart:convert';

class LoginParams {
  String? name;
  String? password;

  LoginParams({
    this.name,
    this.password,
  });

  factory LoginParams.fromRawJson(String str) =>
      LoginParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginParams.fromJson(Map<String, dynamic> json) => LoginParams(
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
      };
}
