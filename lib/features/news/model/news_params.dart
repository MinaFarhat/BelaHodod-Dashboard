import 'dart:convert';

class NewsParams {
  String? title;
  String? description;

  NewsParams({
    this.title,
    this.description,
  });

  factory NewsParams.fromRawJson(String str) =>
      NewsParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsParams.fromJson(Map<String, dynamic> json) => NewsParams(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
