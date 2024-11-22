// To parse this JSON data, do
//
//     final fiscalYearMainResEntity = fiscalYearMainResEntityFromJson(jsonString);

import 'dart:convert';

FiscalYearMainResEntity fiscalYearMainResEntityFromJson(String str) =>
    FiscalYearMainResEntity.fromJson(json.decode(str));

class FiscalYearMainResEntity {
  int? success;
  FiscalYearDataEntity? data;

  FiscalYearMainResEntity({
    this.success,
    this.data,
  });

  factory FiscalYearMainResEntity.fromJson(Map<String, dynamic> json) =>
      FiscalYearMainResEntity(
        success: json["success"],
        data: json["data"] == null
            ? null
            : FiscalYearDataEntity.fromJson(json["data"]),
      );
}

class FiscalYearDataEntity {
  bool? success;
  String? message;
  List<FiscalYearEntity>? fiscalYear;

  FiscalYearDataEntity({
    this.success,
    this.message,
    this.fiscalYear,
  });

  factory FiscalYearDataEntity.fromJson(Map<String, dynamic> json) =>
      FiscalYearDataEntity(
        success: json["success"],
        message: json["message"],
        fiscalYear: json["fiscal_year"] == null
            ? []
            : List<FiscalYearEntity>.from(
                json["fiscal_year"]!.map((x) => FiscalYearEntity.fromJson(x))),
      );
}

class FiscalYearEntity {
  String? id;
  String? fromTo;

  FiscalYearEntity({
    this.id,
    this.fromTo,
  });

  factory FiscalYearEntity.fromJson(Map<String, dynamic> json) =>
      FiscalYearEntity(
        id: json["id"],
        fromTo: json["from_to"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_to": fromTo,
      };
}
