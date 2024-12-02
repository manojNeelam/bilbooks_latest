import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/estimate/domain/entity_list_entity.dart';
import 'package:billbooks_app/features/estimate/domain/repository/estimate_repository.dart';
import 'package:fpdart/fpdart.dart';

class EstimateListUsecase
    implements UseCase<EstimateListMainResEntity, EstimateListReqParams> {
  final EstimateRepository estimateRepository;
  EstimateListUsecase({required this.estimateRepository});
  @override
  Future<Either<Failure, EstimateListMainResEntity>> call(
      EstimateListReqParams params) {
    return estimateRepository.getEstimateList(params);
  }
}

class EstimateListReqParams {
  final String status;
  //draft. sent, approved, invoiced, declined, expired

  final String query;
  final String columnName;
  final String sortOrder;
  final String page;
  final String? startDateStr;
  final String? endDateStr;

  EstimateListReqParams({
    required this.status,
    required this.query,
    required this.columnName,
    required this.sortOrder,
    required this.page,
    this.startDateStr,
    this.endDateStr,
  });
}
