import 'dart:convert';

class NewUserParams {
  String? name;
  String? password;
  String? passwordConfirmation;
  String? phoneNumber;
  String? city;
  String? address;
  String? role;

  NewUserParams(
      {this.name,
      this.password,
      this.passwordConfirmation,
      this.phoneNumber,
      this.city,
      this.address,
      this.role});


  factory NewUserParams.fromRawJson(String str) =>
      NewUserParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewUserParams.fromJson(Map<String, dynamic> json) => NewUserParams(
        name: json["name"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        phoneNumber: json["phone_number"],
        city: json["city"],
        address: json["address"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "phone_number": phoneNumber,
    "city": "Dummy",
    "address": "Dummy ",
    "role": "نظام"
  };

  Map<String, dynamic> wToJson() => {
    "name": name,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "phone_number": phoneNumber,
    "city": "دمشق",
    "address": "ركن الدين الجادة السادسة ",
    "role": "بائع"
  };
}
