class OrganizationDetailsMainResEntity {
  int? success;
  OrganizationDetailsDataEntity? data;

  OrganizationDetailsMainResEntity({
    this.success,
    this.data,
  });
}

class OrganizationDetailsDataEntity {
  bool? success;
  OrganizationEntity? organization;
  String? message;

  OrganizationDetailsDataEntity(
      {this.success, this.organization, this.message});
}

class OrganizationEntity {
  String? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? countryId;
  String? timezoneId;
  String? registrationNo;
  String? phone;
  String? fax;
  String? website;
  String? primarycontactName;
  String? primarycontactEmail;
  String? fiscalYear;
  String? currency;
  String? language;
  String? logo;

  OrganizationEntity({
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.countryId,
    this.timezoneId,
    this.registrationNo,
    this.phone,
    this.fax,
    this.website,
    this.primarycontactName,
    this.primarycontactEmail,
    this.fiscalYear,
    this.currency,
    this.language,
    this.logo,
  });
}
