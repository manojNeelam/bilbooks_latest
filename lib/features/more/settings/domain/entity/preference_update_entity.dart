class PreferenceUpdateMainResEntity {
  int? success;
  PreferenceUpdateDataEntity? data;

  PreferenceUpdateMainResEntity({
    this.success,
    this.data,
  });
}

class PreferenceUpdateDataEntity {
  bool? success;
  String? message;

  PreferenceUpdateDataEntity({
    this.success,
    this.message,
  });
}
