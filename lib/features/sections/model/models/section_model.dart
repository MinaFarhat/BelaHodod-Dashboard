import 'dart:convert';

class SectionModel {
  int? id;
  String? name;
  int? priority;
  int? isVisible;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  SectionModel({
    this.id,
    this.name,
    this.priority,
    this.isVisible,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory SectionModel.fromRawJson(String str) =>
      SectionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        id: json["id"],
        name: json["name"],
        priority: json["priority"],
        isVisible: json["is_visible"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "priority": priority,
        "is_visible": isVisible,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
