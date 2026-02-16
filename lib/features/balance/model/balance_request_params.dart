import 'dart:convert';

class BalanceRequestParams {
  int? amount;

  BalanceRequestParams({
    this.amount,
  });

  factory BalanceRequestParams.fromRawJson(String str) =>
      BalanceRequestParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BalanceRequestParams.fromJson(Map<String, dynamic> json) =>
      BalanceRequestParams(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}
