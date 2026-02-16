import 'dart:convert';

class OfferProductParams {
  String? productId;
  int? quantity;
  String? name;

  OfferProductParams({
    this.productId,
    this.quantity,
    this.name,
  });

  factory OfferProductParams.fromRawJson(String str) =>
      OfferProductParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferProductParams.fromJson(Map<String, dynamic> json) =>
      OfferProductParams(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId ?? 0,
        "quantity": quantity,
      };
}
