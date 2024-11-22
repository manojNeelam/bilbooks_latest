class UpdateOrganizationMainResEntity {
  int? success;
  UpdateOrganizationDataEntity? data;

  UpdateOrganizationMainResEntity({
    this.success,
    this.data,
  });
}

class UpdateOrganizationDataEntity {
  bool? success;
  String? message;

  UpdateOrganizationDataEntity({
    this.success,
    this.message,
  });
}
