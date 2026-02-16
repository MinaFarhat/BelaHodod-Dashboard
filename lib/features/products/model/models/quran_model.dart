import 'dart:convert';

class QuranModel {
  int? id;
  String? publisher;
  String? size;
  dynamic numOfPages;
  String? printType;
  String? specifications;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuranModel({
    this.id,
    this.publisher,
    this.size,
    this.numOfPages,
    this.printType,
    this.specifications,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory QuranModel.fromRawJson(String str) =>
      QuranModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuranModel.fromJson(Map<String, dynamic> json) => QuranModel(
        id: json["id"],
        publisher: json["publisher"],
        size: json["size"],
        numOfPages: json["num_of_pages"],
        printType: json["print_type"],
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
        "publisher": publisher,
        "size": size,
        "num_of_pages": numOfPages,
        "print_type": printType,
        "specifications": specifications,
      };
}
