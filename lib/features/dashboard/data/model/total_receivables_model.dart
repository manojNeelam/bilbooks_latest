// To parse this JSON data, do
//
//     final totalReceivablesMainResModel = totalReceivablesMainResModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entity/total_receivables_entity.dart';

TotalReceivablesMainResModel totalReceivablesMainResModelFromJson(String str) =>
    TotalReceivablesMainResModel.fromJson(json.decode(str));

class TotalReceivablesMainResModel extends TotalReceivablesMainResEntity {
  TotalReceivablesMainResModel({
    int? success,
    TotalReceivablesDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory TotalReceivablesMainResModel.fromJson(Map<String, dynamic> json) =>
      TotalReceivablesMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : TotalReceivablesDataModel.fromJson(json["data"]),
      );
}

class TotalReceivablesDataModel extends TotalReceivablesDataEntity {
  TotalReceivablesDataModel({
    bool? success,
    List<TotalReceivablesModel>? data,
    String? message,
  }) : super(
          data: data,
          success: success,
          message: message,
        );

  factory TotalReceivablesDataModel.fromJson(Map<String, dynamic> json) =>
      TotalReceivablesDataModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<TotalReceivablesModel>.from(
                json["data"]!.map((x) => TotalReceivablesModel.fromJson(x))),
        message: json["message"],
      );
}

class TotalReceivablesModel extends TotalReceivablesEntity {
  TotalReceivablesModel({
    String? currency,
    dynamic today,
    dynamic the130Days,
    dynamic the3160Days,
    dynamic the6190Days,
    dynamic the90Days,
  }) : super(
          currency: currency,
          today: today,
          the130Days: the130Days,
          the3160Days: the3160Days,
          the6190Days: the6190Days,
          the90Days: the90Days,
        );

  factory TotalReceivablesModel.fromJson(Map<String, dynamic> json) =>
      TotalReceivablesModel(
        currency: json["currency"],
        today: json["Today"],
        the130Days: json["1-30 Days"],
        the3160Days: json["31-60 Days"],
        the6190Days: json["61-90 Days"],
        the90Days: json["> 90 Days"],
      );
}
