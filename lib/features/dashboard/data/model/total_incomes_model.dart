import 'dart:convert';

import '../../domain/entity/total_incomes_entity.dart';

TotalIncomesMainResModel totalIncomesMainResModelFromJson(String str) =>
    TotalIncomesMainResModel.fromJson(json.decode(str));

class TotalIncomesMainResModel extends TotalIncomesMainResEntity {
  TotalIncomesMainResModel({
    int? success,
    TotalIncomesDataModel? data,
  }) : super(
          data: data,
          success: success,
        );

  factory TotalIncomesMainResModel.fromJson(Map<String, dynamic> json) =>
      TotalIncomesMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : TotalIncomesDataModel.fromJson(json["data"]),
      );
}

class TotalIncomesDataModel extends TotalIncomesDataEntity {
  TotalIncomesDataModel({
    bool? success,
    List<TotalIncomesModel>? data,
    String? message,
  }) : super(
          data: data,
          success: success,
          message: message,
        );

  factory TotalIncomesDataModel.fromJson(Map<String, dynamic> json) =>
      TotalIncomesDataModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<TotalIncomesModel>.from(
                json["data"]!.map((x) => TotalIncomesModel.fromJson(x))),
        message: json["message"],
      );
}

class TotalIncomesModel extends TotalIncomesEntity {
  TotalIncomesModel({
    String? currency,
    String? today,
    String? thisWeek,
    String? thisMonth,
    String? thisQuarter,
    String? thisFiscalYear,
  }) : super(
          currency: currency,
          today: today,
          thisFiscalYear: thisFiscalYear,
          thisMonth: thisMonth,
          thisQuarter: thisQuarter,
          thisWeek: thisWeek,
        );

  factory TotalIncomesModel.fromJson(Map<String, dynamic> json) =>
      TotalIncomesModel(
        currency: json["currency"],
        today: json["Today"],
        thisWeek: json["This Week"],
        thisMonth: json["This Month"],
        thisQuarter: json["This Quarter"],
        thisFiscalYear: json["This Fiscal Year"],
      );
}
