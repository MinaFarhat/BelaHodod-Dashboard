import 'dart:convert';

class SectionParams {
  String? name;
  int? priority;
  bool? isVisible;
  String? description;

  SectionParams({
    this.name,
    this.priority,
    this.isVisible,
    this.description,
  });

  factory SectionParams.fromRawJson(String str) =>
      SectionParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionParams.fromJson(Map<String, dynamic> json) => SectionParams(
        name: json["name"],
        priority: json["priority"],
        isVisible: json["is_visible"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "priority": priority ?? 1,
        "is_visible": isVisible ?? true,
        "description": description,
      };
}
