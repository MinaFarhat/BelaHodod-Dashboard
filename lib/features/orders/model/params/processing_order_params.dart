import 'dart:convert';

class ProcessingOrderParams {
  String? deliveryMethod;
  String? deliveryCost;

  ProcessingOrderParams({
    this.deliveryMethod,
    this.deliveryCost,
  });

  factory ProcessingOrderParams.fromRawJson(String str) =>
      ProcessingOrderParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProcessingOrderParams.fromJson(Map<String, dynamic> json) =>
      ProcessingOrderParams(
        deliveryMethod: json["delivery_method"],
        deliveryCost: json["delivery_cost"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_method": deliveryMethod,
        "delivery_cost": deliveryCost,
      };
}
