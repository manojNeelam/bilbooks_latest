import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_details_entity.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_list_entity.dart';
import 'package:billbooks_app/features/proforma/domain/usecase/proforma_list_usecase.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProformaRepository {
  Future<Either<Failure, ProformaListMainResEntity>> getProformas(
      ProformaListReqParams params);

  Future<Either<Failure, ProformaDetailsResponseEntity>> getProformaDetails(
      ProformaDetailsReqParams params);
}
