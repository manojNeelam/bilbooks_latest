// To parse this JSON data, do
//
//     final languageMainDataModel = languageMainDataModelFromJson(jsonString);

import 'dart:convert';

LanguageMainDataModel languageMainDataModelFromJson(String str) =>
    LanguageMainDataModel.fromJson(json.decode(str));

String languageMainDataModelToJson(LanguageMainDataModel data) =>
    json.encode(data.toJson());

class LanguageMainDataModel {
  int? success;
  LanguageData? data;

  LanguageMainDataModel({
    this.success,
    this.data,
  });

  factory LanguageMainDataModel.fromJson(Map<String, dynamic> json) =>
      LanguageMainDataModel(
        success: json["success"],
        data: json["data"] == null ? null : LanguageData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class LanguageData {
  bool? success;
  String? message;
  List<LanguageModel>? language;

  LanguageData({
    this.success,
    this.message,
    this.language,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
        success: json["success"],
        message: json["message"],
        language: json["language"] == null
            ? []
            : List<LanguageModel>.from(
                json["language"]!.map((x) => LanguageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "language": language == null
            ? []
            : List<dynamic>.from(language!.map((x) => x.toJson())),
      };
}

class LanguageModel {
  String? languageId;
  String? code;
  String? name;
  String? status;
  String? indexno;

  LanguageModel({
    this.languageId,
    this.code,
    this.name,
    this.status,
    this.indexno,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        languageId: json["language_id"],
        code: json["code"],
        name: json["name"],
        status: json["status"],
        indexno: json["indexno"],
      );

  Map<String, dynamic> toJson() => {
        "language_id": languageId,
        "code": code,
        "name": name,
        "status": status,
        "indexno": indexno,
      };
}
