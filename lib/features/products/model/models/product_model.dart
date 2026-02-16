import 'dart:convert';

import 'package:belahododdashboard/features/products/model/models/quran_model.dart';
import 'package:belahododdashboard/features/products/model/models/stationery_model.dart';

import 'book_model.dart';
import 'game_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? barcode;
  String? description;
  int? price;
  int? traderPrice;
  int? quantity;
  int? minimumQuantity;
  String? images;
  int? sectionId;
  dynamic subSectionsId;
  BookModel? book;
  GameModel? game;
  QuranModel? quran;
  StationeryModel? stationery;

  ProductModel({
    this.id,
    this.name,
    this.barcode,
    this.description,
    this.price,
    this.traderPrice,
    this.quantity,
    this.minimumQuantity,
    this.images,
    this.sectionId,
    this.subSectionsId,
    this.book,
    this.game,
    this.quran,
    this.stationery,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        barcode: json["barcode"],
        description: json["description"],
        price: json["price"],
        traderPrice: json["trader_price"],
        quantity: json["quantity"],
        minimumQuantity: json["minimumQuantity"],
        images: json["images"],
        sectionId: json["section_id"],
        subSectionsId: json["subSections_id"],
        book: json["book"] == null ? null : BookModel.fromJson(json["book"]),
        game: json["game"] == null ? null : GameModel.fromJson(json["game"]),
        quran:
            json["quran"] == null ? null : QuranModel.fromJson(json["quran"]),
        stationery: json["stationery"] == null
            ? null
            : StationeryModel.fromJson(json["stationery"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "barcode": barcode,
        "description": description,
        "price": price,
        "trader_price": traderPrice,
        "quantity": quantity,
        "minimumQuantity": minimumQuantity,
        "images": images,
        "section_id": sectionId,
        "subSections_id": subSectionsId,
        "book": book?.toJson(),
        "game": game?.toJson(),
        "quran": quran?.toJson(),
        "stationery": stationery?.toJson(),
      };
}
