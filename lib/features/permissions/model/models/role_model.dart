import 'dart:convert';

class PermessionModel {
  int? id;
  String? name;
  String? description;

  PermessionModel({
    this.id,
    this.name,
    this.description,
  });

  factory PermessionModel.fromRawJson(String str) =>
      PermessionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PermessionModel.fromJson(Map<String, dynamic> json) => PermessionModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
