import 'dart:convert';

import 'package:intl/intl.dart';

import 'offer_product_params.dart';

class OfferParams {
  String? name;
  String? description;
  int? discountRate;
  DateTime? startDate;
  DateTime? endDate;

  List<OfferProductParams>? offerProducts;

  OfferParams(
      {this.name,
      this.description,
      this.discountRate,
      this.startDate,
      this.endDate,
      this.offerProducts});

  factory OfferParams.fromRawJson(String str) =>
      OfferParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferParams.fromJson(Map<String, dynamic> json) => OfferParams(
      name: json["name"],
      description: json["description"],
      discountRate: json["discount_rate"],
      startDate: json["active_from"],
      endDate: json["active_until"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "discount_rate": discountRate,
        "active_from":
            DateFormat('yyyy-MM-dd hh:mm:ss').format(startDate!.toLocal()),
        "active_until":
            DateFormat('yyyy-MM-dd hh:mm:ss').format(endDate!.toLocal()),
      };
}
