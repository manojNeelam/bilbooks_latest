import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/profile/domain/entity/profile_entity.dart';
import 'package:billbooks_app/features/profile/domain/repository/repository.dart';
import 'package:fpdart/fpdart.dart';

class SelectOrganizationUseCase
    implements UseCase<AuthInfoMainResEntity, SelectOrganizationReqParams> {
  final ProfileRepository profileRepository;
  SelectOrganizationUseCase({required this.profileRepository});
  @override
  Future<Either<Failure, AuthInfoMainResEntity>> call(
      SelectOrganizationReqParams params) {
    return profileRepository.selectOraganization(params);
  }
}

class SelectOrganizationReqParams {
  final String id;
  SelectOrganizationReqParams({required this.id});
}

class UpdateProfileUsecase
    implements UseCase<UpdateMyProfileResponseEntity, UpdateProfileReqParams> {
  final ProfileRepository profileRepository;

  UpdateProfileUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, UpdateMyProfileResponseEntity>> call(
      UpdateProfileReqParams params) {
    return profileRepository.updateProfile(params);
  }
}

class UpdateProfileReqParams {
  final String name,
      newEmail,
      confirmEmail,
      currentPassword,
      confirmPassword,
      newPassword;
  final bool changeEmail, changePassword;
  UpdateProfileReqParams(
    this.newEmail,
    this.confirmEmail,
    this.currentPassword,
    this.confirmPassword,
    this.newPassword,
    this.changeEmail,
    this.changePassword, {
    required this.name,
  });
}
