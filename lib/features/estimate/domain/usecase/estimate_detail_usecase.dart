import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../invoice/domain/entities/invoice_details_entity.dart';
import '../repository/estimate_repository.dart';

class EstimateDetailUsecase
    implements
        UseCase<InvoiceDetailsResponseEntity, EstimateDetailUsecaseReqParams> {
  final EstimateRepository estimateRepository;
  EstimateDetailUsecase({required this.estimateRepository});

  @override
  Future<Either<Failure, InvoiceDetailsResponseEntity>> call(
      EstimateDetailUsecaseReqParams params) {
    return estimateRepository.getEstimateDetails(params);
  }
}

class EstimateDetailUsecaseReqParams {
  final String id;
  EstimateDetailUsecaseReqParams({required this.id});
}
