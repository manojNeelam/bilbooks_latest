// To parse this JSON data, do
//
//     final currencyMainDataModel = currencyMainDataModelFromJson(jsonString);

import 'dart:convert';

CurrencyMainDataModel currencyMainDataModelFromJson(String str) =>
    CurrencyMainDataModel.fromJson(json.decode(str));

String currencyMainDataModelToJson(CurrencyMainDataModel data) =>
    json.encode(data.toJson());

class CurrencyMainDataModel {
  int? success;
  CurrencyData? data;

  CurrencyMainDataModel({
    this.success,
    this.data,
  });

  factory CurrencyMainDataModel.fromJson(Map<String, dynamic> json) =>
      CurrencyMainDataModel(
        success: json["success"],
        data: json["data"] == null ? null : CurrencyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class CurrencyData {
  bool? success;
  String? message;
  List<CurrencyModel>? currency;

  CurrencyData({
    this.success,
    this.message,
    this.currency,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) => CurrencyData(
        success: json["success"],
        message: json["message"],
        currency: json["currency"] == null
            ? []
            : List<CurrencyModel>.from(
                json["currency"]!.map((x) => CurrencyModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "currency": currency == null
            ? []
            : List<dynamic>.from(currency!.map((x) => x.toJson())),
      };
}

class CurrencyModel {
  String? currencyId;
  String? code;
  String? name;
  String? symbol;
  String? indexno;

  CurrencyModel({
    this.currencyId,
    this.code,
    this.name,
    this.symbol,
    this.indexno,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        currencyId: json["currency_id"],
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
        indexno: json["indexno"],
      );

  Map<String, dynamic> toJson() => {
        "currency_id": currencyId,
        "code": code,
        "name": name,
        "symbol": symbol,
        "indexno": indexno,
      };
}
