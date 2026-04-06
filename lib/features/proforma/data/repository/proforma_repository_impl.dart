import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/proforma/data/datasource/remote/proforma_remote_datasource.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_details_entity.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_list_entity.dart';
import 'package:billbooks_app/features/proforma/domain/repository/proforma_repository.dart';
import 'package:billbooks_app/features/proforma/domain/usecase/proforma_list_usecase.dart';
import 'package:fpdart/fpdart.dart';

class ProformaRepositoryImpl implements ProformaRepository {
  final ProformaRemoteDatasource proformaRemoteDatasource;
  ProformaRepositoryImpl({required this.proformaRemoteDatasource});

  @override
  Future<Either<Failure, ProformaListMainResEntity>> getProformas(
      ProformaListReqParams params) async {
    try {
      final response = await proformaRemoteDatasource.getProformas(params);
      return right(response);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProformaDetailsResponseEntity>> getProformaDetails(
      ProformaDetailsReqParams params) async {
    try {
      final response =
          await proformaRemoteDatasource.getProformaDetails(params);
      return right(response);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
