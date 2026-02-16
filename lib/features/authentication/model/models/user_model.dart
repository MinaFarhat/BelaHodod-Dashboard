import 'dart:convert';
import 'package:belahododdashboard/features/authentication/model/models/role_model.dart';

class UserModel {
  String? message;
  String? token;
  int? userId;
  String? userName;
  RoleModel? role;

  UserModel({
    this.message,
    this.token,
    this.userId,
    this.userName,
    this.role,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        token: json["token"],
        userId: json["user_id"],
        userName: json["user_name"],
        role: RoleModel.fromJson(json['role']),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user_id": userId,
        "user_name": userName,
        "role": role?.toJson(),
      };
}
