// To parse this JSON data, do
//
//     final organizationDetailsMainResModel = organizationDetailsMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/more/settings/domain/entity/organization_details_entity.dart';

OrganizationDetailsMainResModel organizationDetailsMainResModelFromJson(
        String str) =>
    OrganizationDetailsMainResModel.fromJson(json.decode(str));

class OrganizationDetailsMainResModel extends OrganizationDetailsMainResEntity {
  OrganizationDetailsMainResModel({
    int? success,
    OrganizationDetailsDataModel? data,
  }) : super(data: data, success: success);

  factory OrganizationDetailsMainResModel.fromJson(Map<String, dynamic> json) =>
      OrganizationDetailsMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : OrganizationDetailsDataModel.fromJson(json["data"]),
      );
}

class OrganizationDetailsDataModel extends OrganizationDetailsDataEntity {
  OrganizationDetailsDataModel({
    bool? success,
    OrganizationModel? organization,
    String? message,
  }) : super(organization: organization, success: success, message: message);

  factory OrganizationDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      OrganizationDetailsDataModel(
        success: json["success"],
        message: json["message"],
        organization: json["organization"] == null
            ? null
            : OrganizationModel.fromJson(json["organization"]),
      );
}

class OrganizationModel extends OrganizationEntity {
  OrganizationModel({
    String? id,
    String? name,
    String? address,
    String? city,
    String? state,
    String? zipcode,
    String? countryId,
    String? timezoneId,
    String? registrationNo,
    String? phone,
    String? fax,
    String? website,
    String? primarycontactName,
    String? primarycontactEmail,
    String? fiscalYear,
    String? currency,
    String? language,
    String? logo,
  }) : super(
            name: name,
            city: city,
            state: state,
            zipcode: zipcode,
            countryId: countryId,
            timezoneId: timezoneId,
            address: address,
            logo: logo,
            language: language,
            currency: currency,
            fiscalYear: fiscalYear,
            primarycontactEmail: primarycontactEmail,
            primarycontactName: primarycontactName,
            website: website,
            fax: fax,
            phone: phone,
            registrationNo: registrationNo);

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      OrganizationModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        countryId: json["country_id"],
        timezoneId: json["timezone_id"],
        registrationNo: json["registration_no"],
        phone: json["phone"],
        fax: json["fax"],
        website: json["website"],
        primarycontactName: json["primarycontact_name"],
        primarycontactEmail: json["primarycontact_email"],
        fiscalYear: json["fiscal_year"],
        currency: json["currency"],
        language: json["language"],
        logo: json["logo"],
      );
}
