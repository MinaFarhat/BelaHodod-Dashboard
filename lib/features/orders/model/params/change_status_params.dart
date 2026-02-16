import 'dart:convert';

class ChangeStatusParams {
  String? status;

  ChangeStatusParams({
    this.status,
  });

  factory ChangeStatusParams.fromRawJson(String str) =>
      ChangeStatusParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangeStatusParams.fromJson(Map<String, dynamic> json) =>
      ChangeStatusParams(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
