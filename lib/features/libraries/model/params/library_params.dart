import 'dart:convert';

class LibraryParams {
  String? name;

  LibraryParams({
    this.name,
  });

  factory LibraryParams.fromRawJson(String str) =>
      LibraryParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LibraryParams.fromJson(Map<String, dynamic> json) => LibraryParams(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
