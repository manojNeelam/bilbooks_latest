// To parse this JSON data, do
//
//     final taxListResModel = taxListResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/taxes/domain/models/tax_list_entity.dart';

TaxListResModel taxListResModelFromJson(String str) =>
    TaxListResModel.fromJson(json.decode(str));

class TaxListResModel extends TaxListResEntity {
  TaxListResModel({
    int? success,
    TaxListData? data,
  }) : super(success: success, data: data);

  factory TaxListResModel.fromJson(Map<String, dynamic> json) =>
      TaxListResModel(
        success: json["success"],
        data: json["data"] == null ? null : TaxListData.fromJson(json["data"]),
      );
}

class TaxListData extends TaxDataEntity {
  TaxListData({
    bool? success,
    List<TaxData>? taxes,
    String? message,
  }) : super(success: success, taxes: taxes, message: message);

  factory TaxListData.fromJson(Map<String, dynamic> json) => TaxListData(
        success: json["success"],
        taxes: json["taxes"] == null
            ? []
            : List<TaxData>.from(
                json["taxes"]!.map((x) => TaxData.fromJson(x))),
        message: json["message"],
      );
}

// class Tax {
//   String? id;
//   String? name;
//   int? rate;
//   DateTime? dateCreated;
//   DateTime? dateModified;
//   String? status;

//   Tax({
//     this.id,
//     this.name,
//     this.rate,
//     this.dateCreated,
//     this.dateModified,
//     this.status,
//   });

//   factory Tax.fromJson(Map<String, dynamic> json) => Tax(
//         id: json["id"],
//         name: json["name"],
//         rate: json["rate"],
//         dateCreated: json["date_created"] == null
//             ? null
//             : DateTime.parse(json["date_created"]),
//         dateModified: json["date_modified"] == null
//             ? null
//             : DateTime.parse(json["date_modified"]),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "rate": rate,
//         "date_created": dateCreated?.toIso8601String(),
//         "date_modified": dateModified?.toIso8601String(),
//         "status": status,
//       };
// }
