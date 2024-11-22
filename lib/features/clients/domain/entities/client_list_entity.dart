class ClientResponseEntity {
  int? success;
  ClientResDataEntity? data;

  ClientResponseEntity({
    this.success,
    this.data,
  });
}

class ClientResDataEntity {
  bool? success;
  List<ClientStatusCountEntity>? statusCount;
  Paging? paging;
  List<ClientEntity>? clients;
  String? message;

  ClientResDataEntity({
    this.success,
    this.statusCount,
    this.paging,
    this.clients,
    this.message,
  });
}

class ClientEntity {
  String? id;
  String? clientId;
  String? organizationId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? phone;
  String? countryId;
  String? registrationNo;
  String? website;
  String? currency;
  String? paymentTerms;
  String? language;
  String? enablePortal;
  String? shippingAddress;
  String? shippingCity;
  String? shippingState;
  String? shippingZipcode;
  String? shippingPhone;
  String? shippingCountryId;
  String? remarks;
  String? balance;
  String? status;
  String? createdBy;
  DateTime? dateCreated;
  String? modifiedBy;
  DateTime? dateModified;
  String? contactId;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? countryName;
  String? shippingCountryName;
  List<PersonEntity>? persons;

  ClientEntity({
    this.id,
    this.clientId,
    this.organizationId,
    this.name,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.phone,
    this.countryId,
    this.registrationNo,
    this.website,
    this.currency,
    this.paymentTerms,
    this.language,
    this.enablePortal,
    this.shippingAddress,
    this.shippingCity,
    this.shippingState,
    this.shippingZipcode,
    this.shippingPhone,
    this.shippingCountryId,
    this.remarks,
    this.balance,
    this.status,
    this.createdBy,
    this.dateCreated,
    this.modifiedBy,
    this.dateModified,
    this.contactId,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.countryName,
    this.shippingCountryName,
    this.persons,
  });
}

class PersonEntity {
  String? id;
  String? name;
  String? email;
  String? phone;
  bool? primary;

  PersonEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.primary,
  });
}

class Paging {
  int? from;
  int? to;
  int? totalrecords;
  int? totalpages;
  int? currentpage;
  int? offset;
  int? length;
  int? remainingrecords;

  Paging({
    this.from,
    this.to,
    this.totalrecords,
    this.totalpages,
    this.currentpage,
    this.offset,
    this.length,
    this.remainingrecords,
  });
}

class ClientStatusCountEntity {
  String? allcount;
  String? active;
  String? inactive;
  String? overdue;

  ClientStatusCountEntity({
    this.allcount,
    this.active,
    this.inactive,
    this.overdue,
  });
}
