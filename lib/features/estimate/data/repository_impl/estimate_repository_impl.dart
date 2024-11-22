import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/estimate/data/datasource/estimate_data_source.dart';

import 'package:billbooks_app/features/estimate/domain/entity_list_entity.dart';
import 'package:billbooks_app/features/estimate/domain/usecase/estimate_detail_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/api/api_exception.dart';
import '../../domain/repository/estimate_repository.dart';
import '../../domain/usecase/estimate_list_usecase.dart';

class EstimateRepositoryImpl implements EstimateRepository {
  final EstimateDataSource estimateDataSource;
  EstimateRepositoryImpl({required this.estimateDataSource});
  @override
  Future<Either<Failure, EstimateListMainResEntity>> getEstimateList(
      EstimateListReqParams params) async {
    try {
      final res = await estimateDataSource.getEstimateList(params);
      debugPrint("Estimate Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Estimate Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Estimate Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceDetailsResponseEntity>> getEstimateDetails(
      EstimateDetailUsecaseReqParams params) async {
    try {
      final res = await estimateDataSource.getEstimateDetails(params);
      debugPrint("Estimate Details : success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Estimate Details: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Estimate Details: default error");

      return left(Failure(e.toString()));
    }
  }
}
