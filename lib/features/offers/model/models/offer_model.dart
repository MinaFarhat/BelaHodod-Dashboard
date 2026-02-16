import 'dart:convert';

class OfferModel {
  int? id;
  String? name;
  String? description;
  int? discountRate;
  DateTime? activeFrom;
  DateTime? activeUntil;
  String? image;

  OfferModel({
    this.id,
    this.name,
    this.description,
    this.discountRate,
    this.activeFrom,
    this.activeUntil,
    this.image,
  });

  factory OfferModel.fromRawJson(String str) =>
      OfferModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        discountRate: json["discount_rate"],
        activeFrom: json["active_from"] == null
            ? null
            : DateTime.parse(json["active_from"]),
        activeUntil: json["active_until"] == null
            ? null
            : DateTime.parse(json["active_until"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "discount_rate": discountRate,
        "active_from": activeFrom?.toIso8601String(),
        "active_until": activeUntil?.toIso8601String(),
        "image": image,
      };
}
