import 'dart:convert';

class CouponsModel {
  int? couponId;
  String? senderName;

  CouponsModel({
    this.couponId,
    this.senderName,
  });

  factory CouponsModel.fromRawJson(String str) =>
      CouponsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CouponsModel.fromJson(Map<String, dynamic> json) => CouponsModel(
      couponId: json["coupon_id"], senderName: json["sender_name"]);

  Map<String, dynamic> toJson() => {
        "coupon_id": couponId,
        "sender_name": senderName,
      };
}
