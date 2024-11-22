import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/taxes/data/datasource/remote/tax_remote_datasource.dart';
import 'package:billbooks_app/features/taxes/data/models/add_tax_model.dart';
import 'package:billbooks_app/features/taxes/data/models/tax_delete_data_model.dart';
import 'package:billbooks_app/features/taxes/data/models/tax_list_model.dart';
import 'package:billbooks_app/features/taxes/domain/repository/tax_repository.dart';
import 'package:billbooks_app/features/taxes/domain/usecase/tax_list_usecase.dart';
import 'package:fpdart/fpdart.dart';

class TaxRepositoryImpl implements TaxRepository {
  final TaxRemoteDatasource taxRemoteDatasource;
  TaxRepositoryImpl({required this.taxRemoteDatasource});

  @override
  Future<Either<Failure, TaxListResModel>> getTaxList() async {
    try {
      final res = await taxRemoteDatasource.getTaxList();
      return right(res);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaxAddMainResModel>> addTax(
      AddTaxRequestModel request) async {
    try {
      final res = await taxRemoteDatasource.addTax(request);
      return right(res);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaxDeleteMainResModel>> deleteTax(
      DeleteTaxRequestModel deleteTaxRequestModel) async {
    try {
      final res = await taxRemoteDatasource.deleteTax(deleteTaxRequestModel);
      return right(res);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
