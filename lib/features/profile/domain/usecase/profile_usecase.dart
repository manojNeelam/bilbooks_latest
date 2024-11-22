import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
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
