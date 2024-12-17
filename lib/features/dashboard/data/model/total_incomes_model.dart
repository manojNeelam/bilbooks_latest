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
    List<TotalIncomesMainDataModel>? data,
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
            : List<TotalIncomesMainDataModel>.from(json["data"]!
                .map((x) => TotalIncomesMainDataModel.fromJson(x))),
        message: json["message"],
      );
}

class TotalIncomesMainDataModel extends TotalIncomesMainDataEntity {
  TotalIncomesMainDataModel({
    String? currency,
    TotalIncomesModel? details,
  }) : super(currency: currency, details: details);

  factory TotalIncomesMainDataModel.fromJson(Map<String, dynamic> json) =>
      TotalIncomesMainDataModel(
        currency: json["currency"],
        details: json["details"] == null
            ? null
            : TotalIncomesModel.fromJson(json["details"]),
      );
}

class TotalIncomesModel extends TotalIncomesEntity {
  TotalIncomesModel({
    String? today,
    String? thisWeek,
    String? thisMonth,
    String? thisQuarter,
    String? thisFiscalYear,
  }) : super(
          today: today,
          thisFiscalYear: thisFiscalYear,
          thisMonth: thisMonth,
          thisQuarter: thisQuarter,
          thisWeek: thisWeek,
        );

  factory TotalIncomesModel.fromJson(Map<String, dynamic> json) =>
      TotalIncomesModel(
        today: json["Today"],
        thisWeek: json["This Week"],
        thisMonth: json["This Month"],
        thisQuarter: json["This Quarter"],
        thisFiscalYear: json["This Fiscal Year"],
      );
}
