import 'dart:convert';

class CouponModel {
  int? totalValue;
  int? valueLeft;
  int? currentValue;
  dynamic notes;
  String? senderName;
  String? receiverName;

  CouponModel({
    this.totalValue,
    this.valueLeft,
    this.currentValue,
    this.notes,
    this.senderName,
    this.receiverName,
  });

  factory CouponModel.fromRawJson(String str) =>
      CouponModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        totalValue: json["total_value"],
        valueLeft: json["value_left"],
        currentValue: json["current_value"],
        notes: json["notes"],
        senderName: json["sender_name"],
        receiverName: json["receiver_name"],
      );

  Map<String, dynamic> toJson() => {
        "total_value": totalValue,
        "value_left": valueLeft,
        "current_value": currentValue,
        "notes": notes,
        "sender_name": senderName,
        "receiver_name": receiverName,
      };
}
