import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/settings/domain/entity/organization_details_entity.dart';
import 'package:billbooks_app/features/more/settings/domain/repository/organization_repository.dart';
import 'package:fpdart/fpdart.dart';

class OrganizationListUsecase
    implements
        UseCase<OrganizationDetailsMainResEntity, OrganizationReqParams> {
  final OrganizationRepository organizationRepository;
  OrganizationListUsecase({required this.organizationRepository});
  @override
  Future<Either<Failure, OrganizationDetailsMainResEntity>> call(
      OrganizationReqParams params) {
    return organizationRepository.getOrganizationDetails(params);
  }
}

class OrganizationReqParams {}
