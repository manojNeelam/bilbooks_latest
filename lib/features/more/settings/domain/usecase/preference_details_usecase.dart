import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/preference_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';

class PreferenceDetailsUsecase
    implements UseCase<PreferenceMainResEntity, PreferenceDetailsReqParams> {
  final OrganizationRepository organizationRepository;
  PreferenceDetailsUsecase({required this.organizationRepository});
  @override
  Future<Either<Failure, PreferenceMainResEntity>> call(
      PreferenceDetailsReqParams params) {
    return organizationRepository.getPreference(params);
  }
}

class PreferenceDetailsReqParams {}
