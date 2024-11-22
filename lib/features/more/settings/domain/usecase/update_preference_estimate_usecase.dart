import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/preference_update_entity.dart';

class UpdatePreferenceEstimateUsecase
    implements
        UseCase<PreferenceUpdateMainResEntity,
            UpdatePreferenceEstimateReqParams> {
  final OrganizationRepository organizationRepository;
  UpdatePreferenceEstimateUsecase({required this.organizationRepository});
  @override
  Future<Either<Failure, PreferenceUpdateMainResEntity>> call(
      UpdatePreferenceEstimateReqParams params) {
    return organizationRepository.updateEstimateSettings(params);
  }
}

class UpdatePreferenceEstimateReqParams {
  final String estimateNo;
  final String estimateName;
  final String estimateTemplate;
  final String estimateTerms;
  final String estimateNotes;
  UpdatePreferenceEstimateReqParams({
    required this.estimateName,
    required this.estimateNo,
    required this.estimateNotes,
    required this.estimateTemplate,
    required this.estimateTerms,
  });
}
