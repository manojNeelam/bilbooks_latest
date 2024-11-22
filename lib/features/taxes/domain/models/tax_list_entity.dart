// To parse this JSON data, do
//
//     final taxListResEntity = taxListResEntityFromJson(jsonString);

import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';

class TaxListResEntity {
  int? success;
  TaxDataEntity? data;

  TaxListResEntity({
    this.success,
    this.data,
  });
}

class TaxDataEntity {
  bool? success;
  List<TaxEntity>? taxes;
  String? message;

  TaxDataEntity({
    this.success,
    this.taxes,
    this.message,
  });
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
// }
