import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/estimate/domain/entity_list_entity.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_detail_usecase.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_list_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../invoice/domain/entities/invoice_details_entity.dart';

abstract interface class EstimateRepository {
  Future<Either<Failure, EstimateListMainResEntity>> getEstimateList(
      EstimateListReqParams params);

  Future<Either<Failure, InvoiceDetailsResponseEntity>> getEstimateDetails(
      EstimateDetailUsecaseReqParams params);
}
