import 'dart:convert';

class PointModel {
  int? id;
  String? name;
  int? points;

  PointModel({
    this.id,
    this.name,
    this.points,
  });

  factory PointModel.fromRawJson(String str) =>
      PointModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
        id: json["id"],
        name: json["name"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "points": points,
      };
}
