import 'dart:convert';

class UserInfoParams {
  String? name;
  String? password;
  String? phoneNumber;

  UserInfoParams({
    this.name,
    this.password,
    this.phoneNumber,
  });

  factory UserInfoParams.fromRawJson(String str) =>
      UserInfoParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoParams.fromJson(Map<String, dynamic> json) => UserInfoParams(
        name: json["name"],
        password: json["password"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "phone_number": phoneNumber,
      };
}
