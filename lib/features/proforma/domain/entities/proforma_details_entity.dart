import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';

class ProformaDetailsResponseEntity {
  int? success;
  ProformaDetailResEntity? data;

  ProformaDetailsResponseEntity({
    this.success,
    this.data,
  });
}

class ProformaDetailResEntity {
  bool? success;
  InvoiceEntity? proforma;
  List<ProformaTaxEntity>? taxes;
  List<ClientEntity>? clients;
  List<ProjectEntity>? projects;
  List<ItemListEntity>? items;
  String? message;

  ProformaDetailResEntity({
    this.success,
    this.proforma,
    this.taxes,
    this.clients,
    this.projects,
    this.items,
    this.message,
  });
}

class ProformaTaxEntity {
  String? id;
  String? name;
  dynamic rate;

  ProformaTaxEntity({
    this.id,
    this.name,
    this.rate,
  });
}

class ProformaStaffEntity {
  String? id;
  String? name;
  String? email;
  bool? selected;

  ProformaStaffEntity({
    this.id,
    this.name,
    this.email,
    this.selected,
  });

  factory ProformaStaffEntity.fromInvoiceStaff(dynamic entity) {
    return ProformaStaffEntity(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      selected: entity.selected,
    );
  }
}
