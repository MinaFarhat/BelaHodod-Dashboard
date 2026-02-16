import 'dart:convert';

class GameModel {
  int? id;
  String? targetAge;
  String? goals;
  String? materials;
  String? manufacturer;
  dynamic numOfPlayers;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  GameModel({
    this.id,
    this.targetAge,
    this.goals,
    this.materials,
    this.manufacturer,
    this.numOfPlayers,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory GameModel.fromRawJson(String str) =>
      GameModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      GameModel(
        id: json["id"],
        targetAge: json["target_age"],
        goals: json["goals"],
        materials: json["materials"],
        manufacturer: json["manufacturer"],
        numOfPlayers: json["num_of_players"],
        productId: json["product_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "target_age": targetAge,
        "goals": goals,
        "materials": materials,
        "manufacturer": manufacturer,
        "num_of_players": numOfPlayers,
      };
}
