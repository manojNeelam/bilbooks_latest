// To parse this JSON data, do
//
//     final paperFormatMainResEntity = paperFormatMainResEntityFromJson(jsonString);

import 'dart:convert';

PaperFormatMainResEntity paperFormatMainResEntityFromJson(String str) =>
    PaperFormatMainResEntity.fromJson(json.decode(str));

class PaperFormatMainResEntity {
  int? success;
  PaperFormatData? data;

  PaperFormatMainResEntity({
    this.success,
    this.data,
  });

  factory PaperFormatMainResEntity.fromJson(Map<String, dynamic> json) =>
      PaperFormatMainResEntity(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PaperFormatData.fromJson(json["data"]),
      );
}

class PaperFormatData {
  bool? success;
  String? message;
  List<PaperFormatEntity>? paperFormat;

  PaperFormatData({
    this.success,
    this.message,
    this.paperFormat,
  });

  factory PaperFormatData.fromJson(Map<String, dynamic> json) =>
      PaperFormatData(
        success: json["success"],
        message: json["message"],
        paperFormat: json["paper_format"] == null
            ? []
            : List<PaperFormatEntity>.from(json["paper_format"]!
                .map((x) => PaperFormatEntity.fromJson(x))),
      );
}

class PaperFormatEntity {
  String? format;

  PaperFormatEntity({
    this.format,
  });

  factory PaperFormatEntity.fromJson(Map<String, dynamic> json) =>
      PaperFormatEntity(
        format: json["format"],
      );
}
