import 'dart:convert';

class OrderDetailsModel {
  int? id;
  DateTime? orderDate;
  int? totalCost;
  int? totalNumberOfProducts;
  String? orderStatus;
  String? username;
  String? phoneNumber;
  String? address;
  String? notes;
  String? paymentPicture;
  List<OrderDetail>? orderDetails;

  OrderDetailsModel({
    this.id,
    this.orderDate,
    this.totalCost,
    this.totalNumberOfProducts,
    this.orderStatus,
    this.username,
    this.phoneNumber,
    this.address,
    this.notes,
    this.orderDetails,
    this.paymentPicture,
  });

  factory OrderDetailsModel.fromRawJson(String str) =>
      OrderDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        totalCost: json["total_cost"],
        totalNumberOfProducts: json["total_number_of_products"],
        orderStatus: json["order_status"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        notes: json["notes"],
        paymentPicture: json["payment_picture"],
        orderDetails: json["order_details"] == null
            ? []
            : List<OrderDetail>.from(
            json["order_details"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_date": orderDate?.toIso8601String(),
    "total_cost": totalCost,
    "total_number_of_products": totalNumberOfProducts,
    "order_status": orderStatus,
    "username": username,
    "phone_number": phoneNumber,
    "address": address,
    "notes": notes,
    "payment_picture": paymentPicture,
    "order_details": orderDetails == null
        ? []
        : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}

class OrderDetail {
  int? id;
  String? name;
  int? quantity;
  int? unitPrice;
  int? totalPrice;

  OrderDetail({
    this.id,
    this.name,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
  });

  factory OrderDetail.fromRawJson(String str) =>
      OrderDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quantity": quantity,
    "unit_price": unitPrice,
    "total_price": totalPrice,
  };
}
