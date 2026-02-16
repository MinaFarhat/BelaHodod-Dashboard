import 'dart:convert';

import '../models/book_model.dart';
import '../models/game_model.dart';
import '../models/quran_model.dart';
import '../models/stationery_model.dart';

class ProductParams {
  String? name;
  String? barcode;
  String? description;
  String? price;
  String? traderPrice;
  String? quantity;
  String? minimumQuantity;
  String? sectionId;
  String? subSectionId;
  dynamic subSectionsId;
  BookModel? book;
  GameModel? game;
  QuranModel? quran;
  StationeryModel? stationery;

  ProductParams({
    this.name,
    this.barcode,
    this.description,
    this.price,
    this.traderPrice,
    this.quantity,
    this.minimumQuantity,
    this.sectionId,
    this.subSectionId,
    this.book,
    this.game,
    this.quran,
    this.stationery,
  });

  factory ProductParams.fromRawJson(String str) =>
      ProductParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductParams.fromJson(Map<String, dynamic> json) => ProductParams(
        name: json["name"],
        barcode: json["barcode"],
        description: json["description"],
        price: json["price"],
        traderPrice: json["trader_price"],
        quantity: json["quantity"],
        minimumQuantity: json["minimumQuantity"],
        sectionId: json["section_id"],
        subSectionId: json["subSection_id"],
        book: json["book"] == null ? null : BookModel.fromJson(json["book"]),
        game: json["game"] == null ? null : GameModel.fromJson(json["game"]),
        quran:
            json["quran"] == null ? null : QuranModel.fromJson(json["quran"]),
        stationery: json["stationery"] == null
            ? null
            : StationeryModel.fromJson(json["stationery"]),
      );

  Map<String, dynamic> toJsonWithSubsectionId() {
    return {
      "name": name ?? "",
      "barcode": barcode ?? "",
      "description": description ?? "",
      "price": price ?? "",
      "trader_price": traderPrice ?? "",
      "quantity": quantity ?? "",
      "minimumQuantity": minimumQuantity ?? "",
      "section_id": sectionId ?? "",
      "subSections_id": subSectionId ?? "",
      if (book != null) "book": book?.toJson(),
      if (game != null) "game": game?.toJson(),
      if (quran != null) "quran": quran?.toJson(),
      if (stationery != null) "stationery": stationery?.toJson(),
    };
  }

  Map<String, dynamic> toJson() => {
        "name": name ?? "",
        "barcode": barcode ?? "",
        "description": description ?? "",
        "price": price ?? "",
        "trader_price": traderPrice ?? "",
        "quantity": quantity ?? "",
        "minimumQuantity": minimumQuantity ?? "",
        "section_id": sectionId ?? "",
        if (book != null) "book": book?.toJson(),
        if (game != null) "game": game?.toJson(),
        if (quran != null) "quran": quran?.toJson(),
        if (stationery != null) "stationery": stationery?.toJson(),
      };
}
