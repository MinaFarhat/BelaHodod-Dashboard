import 'dart:convert';

class SubsectionModel {
  int? id;
  String? name;
  int? sectionId;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubsectionModel({
    this.id,
    this.name,
    this.sectionId,
    this.createdAt,
    this.updatedAt,
  });

  factory SubsectionModel.fromRawJson(String str) =>
      SubsectionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubsectionModel.fromJson(Map<String, dynamic> json) =>
      SubsectionModel(
        id: json["id"],
        name: json["name"],
        sectionId: json["section_id"],
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
        "section_id": sectionId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
