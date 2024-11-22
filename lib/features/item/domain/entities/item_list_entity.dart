import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import '../../../clients/domain/entities/client_list_entity.dart';

class ItemsResponseEntity {
  int? success;
  ItemResDataEntity? data;

  ItemsResponseEntity({
    this.success,
    this.data,
  });
}

class ItemResDataEntity {
  bool? success;
  List<StatusCountEntity>? statusCount;
  Paging? paging;
  List<ItemListEntity>? items;
  String? message;

  ItemResDataEntity({
    this.success,
    this.statusCount,
    this.paging,
    this.items,
    this.message,
  });
}

class ItemListEntity {
  String? id;
  String? type;
  String? name;
  String? sku;
  String? hsn;
  String? description;
  String? rate;
  String? unit;
  List<TaxEntity>? taxes;
  bool? trackInventory;
  int? stock;
  DateTime? dateCreated;
  DateTime? dateModified;
  String? status;

  ItemListEntity({
    this.id,
    this.type,
    this.name,
    this.sku,
    this.hsn,
    this.description,
    this.rate,
    this.unit,
    this.taxes,
    this.trackInventory,
    this.stock,
    this.dateCreated,
    this.dateModified,
    this.status,
  });
}

class StatusCountEntity {
  String? allcount;
  String? active;
  String? inactive;
  String? service;

  StatusCountEntity({
    this.allcount,
    this.active,
    this.inactive,
    this.service,
  });
}
