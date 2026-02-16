import 'dart:convert';

class PermissionModel{
  int? id;
  String? name;

  PermissionModel({
  this.id,
  this.name,
  });


  factory PermissionModel.fromRawJson(String str) =>
      PermissionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PermissionModel.fromJson(Map<String, dynamic> json) => PermissionModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}