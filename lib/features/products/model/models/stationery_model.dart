import 'dart:convert';

class StationeryModel {
  int? id;
  String? goals;
  String? materials;
  String? manufacturer;
  String? specifications;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  StationeryModel({
    this.id,
    this.goals,
    this.materials,
    this.manufacturer,
    this.specifications,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory StationeryModel.fromRawJson(String str) =>
      StationeryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StationeryModel.fromJson(Map<String, dynamic> json) =>
      StationeryModel(
        id: json["id"],
        goals: json["goals"],
        materials: json["materials"],
        manufacturer: json["manufacturer"],
        specifications: json["specifications"],
        productId: json["product_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "goals": goals,
        "materials": materials,
        "manufacturer": manufacturer,
        "specifications": specifications,
      };
}
