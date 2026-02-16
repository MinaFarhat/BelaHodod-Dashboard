import 'dart:convert';

class UsersParams {
  String? name;
  String? password;
  String? phoneNumber;
UsersParams({
    this.name,
  this.password,
  this.phoneNumber
});


  factory UsersParams.fromRawJson(String str) =>
      UsersParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersParams.fromJson(Map<String, dynamic> json) => UsersParams(
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