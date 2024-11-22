// To parse this JSON data, do
//
//     final dateFormaterMainResEntity = dateFormaterMainResEntityFromJson(jsonString);

import 'dart:convert';

DateFormaterMainResEntity dateFormaterMainResEntityFromJson(String str) =>
    DateFormaterMainResEntity.fromJson(json.decode(str));

class DateFormaterMainResEntity {
  int? success;
  DateFormaterData? data;

  DateFormaterMainResEntity({
    this.success,
    this.data,
  });

  factory DateFormaterMainResEntity.fromJson(Map<String, dynamic> json) =>
      DateFormaterMainResEntity(
        success: json["success"],
        data: json["data"] == null
            ? null
            : DateFormaterData.fromJson(json["data"]),
      );
}

class DateFormaterData {
  bool? success;
  String? message;
  List<DateFormatEntity>? dateFormat;

  DateFormaterData({
    this.success,
    this.message,
    this.dateFormat,
  });

  factory DateFormaterData.fromJson(Map<String, dynamic> json) =>
      DateFormaterData(
        success: json["success"],
        message: json["message"],
        dateFormat: json["date_format"] == null
            ? []
            : List<DateFormatEntity>.from(
                json["date_format"]!.map((x) => DateFormatEntity.fromJson(x))),
      );
}

class DateFormatEntity {
  String? format;

  DateFormatEntity({
    this.format,
  });

  factory DateFormatEntity.fromJson(Map<String, dynamic> json) =>
      DateFormatEntity(
        format: json["format"],
      );

  // Map<String, dynamic> toJson() => {
  //       "format": format,
  //     };
}
