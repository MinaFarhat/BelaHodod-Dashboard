import 'dart:convert';

class LibraryModel {
  int? id;
  String? name;

  LibraryModel({
    this.id,
    this.name,
  });

  factory LibraryModel.fromRawJson(String str) =>
      LibraryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LibraryModel.fromJson(Map<String, dynamic> json) => LibraryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
