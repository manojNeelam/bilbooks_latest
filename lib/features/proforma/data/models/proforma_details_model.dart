import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_list_model.dart';
import 'package:billbooks_app/features/item/data/models/item_list_data_model.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_details_entity.dart';
import 'package:billbooks_app/features/project/data/models/project_list_data.dart';

class ProformaDetailsResponseModel extends ProformaDetailsResponseEntity {
  ProformaDetailsResponseModel({
    int? success,
    ProformaDetailResModel? data,
  }) : super(success: success, data: data);

  factory ProformaDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProformaDetailsResponseModel(
      success: json['success'],
      data: json['data'] == null
          ? null
          : ProformaDetailResModel.fromJson(json['data']),
    );
  }
}

class ProformaDetailResModel extends ProformaDetailResEntity {
  ProformaDetailResModel({
    bool? success,
    InvoiceModel? proforma,
    List<ProformaTaxModel>? taxes,
    List<ClientModel>? clients,
    List<ProjectData>? projects,
    List<ItemDataModel>? items,
    String? message,
  }) : super(
          success: success,
          proforma: proforma,
          taxes: taxes,
          clients: clients,
          projects: projects,
          items: items,
          message: message,
        );

  factory ProformaDetailResModel.fromJson(Map<String, dynamic> json) {
    return ProformaDetailResModel(
      success: json['success'],
      proforma: json['proforma'] == null
          ? null
          : InvoiceModel.fromJson(json['proforma']),
      taxes: json['taxes'] == null
          ? []
          : List<ProformaTaxModel>.from(
              json['taxes'].map((x) => ProformaTaxModel.fromJson(x))),
      clients: json['clients'] == null
          ? []
          : List<ClientModel>.from(
              json['clients'].map((x) => ClientModel.fromJson(x))),
      projects: json['projects'] == null
          ? []
          : List<ProjectData>.from(
              json['projects'].map((x) => ProjectData.fromJson(x))),
      items: json['items'] == null
          ? []
          : List<ItemDataModel>.from(
              json['items'].map((x) => ItemDataModel.fromJson(x))),
      message: json['message'],
    );
  }
}

class ProformaTaxModel extends ProformaTaxEntity {
  ProformaTaxModel({
    String? id,
    String? name,
    dynamic rate,
  }) : super(id: id, name: name, rate: rate);

  factory ProformaTaxModel.fromJson(Map<String, dynamic> json) {
    return ProformaTaxModel(
      id: json['id'],
      name: json['name'],
      rate: json['rate'],
    );
  }
}
