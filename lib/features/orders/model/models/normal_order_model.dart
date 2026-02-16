import 'dart:convert';

class NormalOrderModel {
  int? id;
  String? address;
  String? notes;
  DateTime? date;
  String? paymentMethod;
  String? paymentPicture;
  NormalOrderModel({
    this.id,
    this.address,
    this.notes,
    this.date,
    this.paymentMethod,
    this.paymentPicture,
  });

  factory NormalOrderModel.fromRawJson(String str) =>
      NormalOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NormalOrderModel.fromJson(Map<String, dynamic> json) =>
      NormalOrderModel(
        id: json["id"],
        address: json["address"],
        notes: json["notes"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        paymentMethod: json["payment_method"],
        paymentPicture: json["payment_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "notes": notes,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "payment_method": paymentMethod,
    "payment_picture": paymentPicture,

  };
}
