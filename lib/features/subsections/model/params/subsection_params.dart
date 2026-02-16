import 'dart:convert';

class SubsectionParams {
  String? name;

  SubsectionParams({
    this.name,
  });

  factory SubsectionParams.fromRawJson(String str) =>
      SubsectionParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubsectionParams.fromJson(Map<String, dynamic> json) =>
      SubsectionParams(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
