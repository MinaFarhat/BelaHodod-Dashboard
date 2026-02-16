import 'dart:convert';

class BookModel {
  int? id;
  String? author;
  String? translator;
  String? dimensions;
  dynamic numOfPages;
  String? printType;
  String? targetAge;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookModel({
    this.id,
    this.author,
    this.translator,
    this.dimensions,
    this.numOfPages,
    this.printType,
    this.targetAge,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory BookModel.fromRawJson(String str) =>
      BookModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        author: json["author"],
        translator: json["translator"],
        dimensions: json["dimensions"],
        numOfPages: json["num_of_pages"],
        printType: json["print_type"],
        targetAge: json["target_age"],
        productId: json["product_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "translator": translator,
        "dimensions": dimensions,
        "num_of_pages": numOfPages,
        "print_type": printType,
        "target_age": targetAge,
      };
}
