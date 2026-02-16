import 'dart:convert';

class WholesaleUserModel {
  int? id;
  String? name;
  String? roleName;
  int? points;
  String? phoneNumber;
  int? roleId;
  String? profilePicture;
  int? balance;

  WholesaleUserModel(
      {this.id,
      this.name,
      this.roleName,
      this.points,
      this.phoneNumber,
      this.roleId,
      this.profilePicture,
      this.balance});

  factory WholesaleUserModel.fromRawJson(String str) =>
      WholesaleUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WholesaleUserModel.fromJson(Map<String, dynamic> json) =>
      WholesaleUserModel(
        id: json["id"],
        name: json["name"],
        roleName: json["role_name"],
        points: json["points"],
        phoneNumber: json["phone_number"],
        roleId: json["roleId"],
        profilePicture: json["profilePicture"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role_name": roleName,
        "points": points,
        "phone_number": phoneNumber,
        "roleId": roleId,
        "profilePicture": profilePicture,
        "balance": balance,
      };
}
