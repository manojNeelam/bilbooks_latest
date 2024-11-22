// To parse this JSON data, do
//
//     final taxAddResEntity = taxAddResEntityFromJson(jsonString);

import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';

class TaxAddMainResEntity {
  int? success;
  TaxResDataEntity? data;

  TaxAddMainResEntity({
    this.success,
    this.data,
  });
}

class TaxResDataEntity {
  bool? success;
  TaxEntity? tax;
  String? message;

  TaxResDataEntity({
    this.success,
    this.tax,
    this.message,
  });
}

// class Tax {
//   String? id;
//   String? name;
//   int? rate;
//   DateTime? dateCreated;
//   dynamic dateModified;
//   String? status;

//   Tax({
//     this.id,
//     this.name,
//     this.rate,
//     this.dateCreated,
//     this.dateModified,
//     this.status,
//   });
// }
