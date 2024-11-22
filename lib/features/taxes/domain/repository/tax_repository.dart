import 'package:billbooks_app/features/taxes/data/models/add_tax_model.dart';
import 'package:billbooks_app/features/taxes/data/models/tax_delete_data_model.dart';
import 'package:billbooks_app/features/taxes/data/models/tax_list_model.dart';
import 'package:billbooks_app/features/taxes/domain/usecase/tax_list_usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';

abstract interface class TaxRepository {
  Future<Either<Failure, TaxListResModel>> getTaxList();
  Future<Either<Failure, TaxAddMainResModel>> addTax(
      AddTaxRequestModel request);
  Future<Either<Failure, TaxDeleteMainResModel>> deleteTax(
      DeleteTaxRequestModel deleteTaxRequestModel);
}
