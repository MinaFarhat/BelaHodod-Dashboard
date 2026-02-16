import 'dart:convert';

class BalanceRequestModel {
  int? id;
  String? userName;
  int? userId;
  int? balance;
  List<String>? image;

  BalanceRequestModel({
    this.id,
    this.userName,
    this.userId,
    this.balance,
    this.image,
  });

  factory BalanceRequestModel.fromRawJson(String str) =>
      BalanceRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BalanceRequestModel.fromJson(Map<String, dynamic> json) =>
      BalanceRequestModel(
        id: json["id"],
        userName: json["user_name"],
        userId: json["user_id"],
        balance: json["balance"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "user_id": userId,
        "balance": balance,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
      };
}
