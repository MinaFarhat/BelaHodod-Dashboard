import 'dart:convert';

class PermissionParams{
  String? id;
  String? name;

  PermissionParams({
   this.id,
   this.name
});

  factory PermissionParams.fromRawJson(String str) =>
      PermissionParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PermissionParams.fromJson(Map<String, dynamic> json) => PermissionParams(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

}

