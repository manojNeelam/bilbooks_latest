// To parse this JSON data, do
//
//     final updateMyProfileEntity = updateMyProfileEntityFromJson(jsonString);

class UpdateMyProfileResponseEntity {
  int? success;
  UpdateMyProfileDataEntity? data;

  UpdateMyProfileResponseEntity({
    this.success,
    this.data,
  });
}

class UpdateMyProfileDataEntity {
  bool? success;
  String? message;

  UpdateMyProfileDataEntity({
    this.success,
    this.message,
  });
}
