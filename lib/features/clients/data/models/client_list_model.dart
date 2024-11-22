// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';

ClientResponseModel clientFromJson(String str) =>
    ClientResponseModel.fromJson(json.decode(str));

String clientToJson(ClientResponseModel data) => json.encode(data.toJson());

class ClientResponseModel extends ClientResponseEntity {
  ClientResponseModel({
    int? success,
    ClientResDataModel? data,
  }) : super(data: data, success: success);

  factory ClientResponseModel.fromJson(Map<String, dynamic> json) =>
      ClientResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ClientResDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
      };
}

class ClientResDataModel extends ClientResDataEntity {
  ClientResDataModel({
    bool? success,
    List<ClientStatusCountModel>? statusCount,
    Paging? paging,
    List<ClientModel>? clients,
    String? message,
  }) : super(
            clients: clients,
            success: success,
            paging: paging,
            message: message);

  factory ClientResDataModel.fromJson(Map<String, dynamic> json) =>
      ClientResDataModel(
        success: json["success"],
        statusCount: json["status_count"] == null
            ? []
            : List<ClientStatusCountModel>.from(json["status_count"]!
                .map((x) => ClientStatusCountModel.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingModel.fromJson(json["paging"]),
        clients: json["clients"] == null
            ? []
            : List<ClientModel>.from(
                json["clients"]!.map((x) => ClientModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_count": statusCount == null
            ? []
            : List<dynamic>.from(statusCount!.map((x) => x)),
        "paging": paging,
        "clients":
            clients == null ? [] : List<dynamic>.from(clients!.map((x) => x)),
        "message": message,
      };
}

class ClientModel extends ClientEntity {
  ClientModel(
      {String? id,
      String? clientId,
      String? organizationId,
      String? name,
      String? address,
      String? city,
      String? state,
      String? zipcode,
      String? phone,
      String? countryId,
      String? registrationNo,
      String? website,
      String? currency,
      String? paymentTerms,
      String? language,
      String? enablePortal,
      String? shippingAddress,
      String? shippingCity,
      String? shippingState,
      String? shippingZipcode,
      String? shippingPhone,
      String? shippingCountryId,
      String? remarks,
      String? balance,
      String? status,
      String? createdBy,
      DateTime? dateCreated,
      String? modifiedBy,
      DateTime? dateModified,
      String? contactId,
      String? contactName,
      String? contactEmail,
      String? contactPhone,
      String? countryName,
      String? shippingCountryName,
      List<PersonModel>? persons})
      : super(
            id: id,
            clientId: clientId,
            organizationId: organizationId,
            name: name,
            address: address,
            city: city,
            state: state,
            zipcode: zipcode,
            phone: phone,
            countryId: countryId,
            registrationNo: registrationNo,
            website: website,
            currency: currency,
            paymentTerms: paymentTerms,
            language: language,
            enablePortal: enablePortal,
            shippingAddress: shippingAddress,
            shippingCity: shippingCity,
            shippingState: shippingState,
            shippingZipcode: shippingZipcode,
            shippingPhone: shippingPhone,
            shippingCountryId: shippingCountryId,
            remarks: remarks,
            balance: balance,
            status: status,
            createdBy: createdBy,
            dateCreated: dateCreated,
            modifiedBy: modifiedBy,
            dateModified: dateModified,
            contactId: contactId,
            contactName: contactName,
            contactEmail: contactEmail,
            contactPhone: contactPhone,
            countryName: countryName,
            shippingCountryName: shippingCountryName,
            persons: persons);

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        clientId: json["client_id"],
        organizationId: json["organization_id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        phone: json["phone"],
        countryId: json["country_id"],
        registrationNo: json["registration_no"],
        website: json["website"],
        currency: json["currency"],
        paymentTerms: json["payment_terms"],
        language: json["language"],
        enablePortal: json["enable_portal"],
        shippingAddress: json["shipping_address"],
        shippingCity: json["shipping_city"],
        shippingState: json["shipping_state"],
        shippingZipcode: json["shipping_zipcode"],
        shippingPhone: json["shipping_phone"],
        shippingCountryId: json["shipping_country_id"],
        remarks: json["remarks"],
        balance: json["balance"],
        status: json["status"],
        createdBy: json["created_by"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        modifiedBy: json["modified_by"],
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        contactId: json["contact_id"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        countryName: json["country_name"],
        shippingCountryName: json["shipping_country_name"],
        persons: json["persons"] == null
            ? []
            : List<PersonModel>.from(
                json["persons"]!.map((x) => PersonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "organization_id": organizationId,
        "name": name,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "phone": phone,
        "country_id": countryId,
        "registration_no": registrationNo,
        "website": website,
        "currency": currency,
        "payment_terms": paymentTerms,
        "language": language,
        "enable_portal": enablePortal,
        "shipping_address": shippingAddress,
        "shipping_city": shippingCity,
        "shipping_state": shippingState,
        "shipping_zipcode": shippingZipcode,
        "shipping_phone": shippingPhone,
        "shipping_country_id": shippingCountryId,
        "remarks": remarks,
        "balance": balance,
        "status": status,
        "created_by": createdBy,
        "date_created": dateCreated?.toIso8601String(),
        "modified_by": modifiedBy,
        "date_modified": dateModified?.toIso8601String(),
        "contact_id": contactId,
        "contact_name": contactName,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "country_name": countryName,
        "shipping_country_name": shippingCountryName,
        "persons":
            persons == null ? [] : List<dynamic>.from(persons!.map((x) => x)),
      };
}

class PersonModel extends PersonEntity {
  PersonModel(
      {String? id, String? name, String? email, String? phone, bool? primary})
      : super(email: email, name: name, phone: phone, primary: primary, id: id);

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        primary: json["primary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "primary": primary,
      };
}

class PagingModel extends Paging {
  PagingModel(
      {int? from,
      int? to,
      int? totalrecords,
      int? totalpages,
      int? currentpage,
      int? offset,
      int? length,
      int? remainingrecords})
      : super(
            currentpage: currentpage,
            from: from,
            to: to,
            totalpages: totalpages,
            totalrecords: totalrecords,
            offset: offset,
            length: length);

  factory PagingModel.fromJson(Map<String, dynamic> json) => PagingModel(
        from: json["from"],
        to: json["to"],
        totalrecords: json["totalrecords"],
        totalpages: json["totalpages"],
        currentpage: json["currentpage"],
        offset: json["offset"],
        length: json["length"],
        remainingrecords: json["remainingrecords"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "totalrecords": totalrecords,
        "totalpages": totalpages,
        "currentpage": currentpage,
        "offset": offset,
        "length": length,
        "remainingrecords": remainingrecords,
      };
}

class ClientStatusCountModel extends ClientStatusCountEntity {
  ClientStatusCountModel(
      {String? allcount, String? active, String? inactive, String? overdue})
      : super(
            allcount: allcount,
            active: active,
            inactive: inactive,
            overdue: overdue);

  factory ClientStatusCountModel.fromJson(Map<String, dynamic> json) =>
      ClientStatusCountModel(
        allcount: json["allcount"],
        active: json["active"],
        inactive: json["inactive"],
        overdue: json["overdue"],
      );

  Map<String, dynamic> toJson() => {
        "allcount": allcount,
        "active": active,
        "inactive": inactive,
        "overdue": overdue,
      };
}
