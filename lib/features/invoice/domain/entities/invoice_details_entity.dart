// To parse this JSON data, do
//
//     final invoiceDetailsResponseEntity = invoiceDetailsResponseEntityFromJson(jsonString);

import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';

import '../../../clients/domain/entities/client_list_entity.dart';
import '../../../item/domain/entities/item_list_entity.dart';
import 'invoice_list_entity.dart';

class InvoiceDetailsResponseEntity {
  int? success;
  InvoiceDetailResEntity? data;

  InvoiceDetailsResponseEntity({
    this.success,
    this.data,
  });
}

class InvoiceDetailResEntity {
  bool? success;
  InvoiceEntity? invoice;
  InvoiceEntity? estimate;
  List<TaxEntity>? taxes;
  List<ClientEntity>? clients;
  List<ProjectEntity>? projects;
  List<ItemListEntity>? items;
  List<InvoiceHistoryEntity>? history;
  List<PaymentEntity>? payments;

  String? message;

  InvoiceDetailResEntity({
    this.success,
    this.invoice,
    this.taxes,
    this.clients,
    this.projects,
    this.items,
    this.message,
    this.history,
    this.payments,
    this.estimate,
  });
}

// class ClientEntity {
//   String? id;
//   String? name;
//   String? city;

//   ClientEntity({
//     this.id,
//     this.name,
//     this.city,
//   });
// }

// class InvoiceEntity {
//   String? no;
//   String? heading;
//   String? dueTerms;
//   List<EmailtoMystaffEntity>? emailtoMystaff;
//   String? notes;
//   String? terms;

//   InvoiceEntity({
//     this.no,
//     this.heading,
//     this.dueTerms,
//     this.emailtoMystaff,
//     this.notes,
//     this.terms,
//   });
// }

class EmailtoMystaffEntity {
  String? id;
  String? name;
  String? email;
  bool? selected;

  EmailtoMystaffEntity({
    this.id,
    this.name,
    this.email,
    this.selected,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "selected": selected,
      };
}

class ItemEntity {
  String? id;
  String? sku;
  String? name;
  String? rate;
  String? unit;
  bool? trackInventory;
  int? stock;

  ItemEntity({
    this.id,
    this.sku,
    this.name,
    this.rate,
    this.unit,
    this.trackInventory,
    this.stock,
  });
}

class TaxEntity {
  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "name": name ?? "",
        "rate": rate.toString(),
      };
  String? id;
  String? name;
  dynamic rate;

  TaxEntity({
    this.id,
    this.name,
    this.rate,
  });
}

class InvoiceHistoryEntity {
  String? date;
  String? description;
  String? createdBy;

  InvoiceHistoryEntity({
    this.date,
    this.description,
    this.createdBy,
  });
}

class PaymentEntity {
  String? id;
  String? date;
  DateTime? dateYmd;
  String? amount;
  String? methodId;
  dynamic methodName;
  String? refno;
  String? notes;

  PaymentEntity({
    this.id,
    this.date,
    this.dateYmd,
    this.amount,
    this.methodId,
    this.methodName,
    this.refno,
    this.notes,
  });
}
