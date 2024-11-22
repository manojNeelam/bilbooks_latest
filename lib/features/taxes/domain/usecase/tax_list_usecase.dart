import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/taxes/data/models/add_tax_model.dart';
import 'package:billbooks_app/features/taxes/data/models/tax_delete_data_model.dart';
import 'package:billbooks_app/features/taxes/domain/models/tax_list_entity.dart';
import 'package:billbooks_app/features/taxes/domain/repository/tax_repository.dart';
import 'package:fpdart/fpdart.dart';

class TaxListUsecase implements UseCase<TaxListResEntity, TaxListRequestModel> {
  final TaxRepository taxRepository;
  TaxListUsecase({required this.taxRepository});
  @override
  Future<Either<Failure, TaxListResEntity>> call(TaxListRequestModel params) {
    return taxRepository.getTaxList();
  }
}

class TaxListRequestModel {}

class AddTaxUseCase implements UseCase<TaxAddMainResModel, AddTaxRequestModel> {
  final TaxRepository taxRepository;
  AddTaxUseCase({required this.taxRepository});
  @override
  Future<Either<Failure, TaxAddMainResModel>> call(AddTaxRequestModel params) {
    return taxRepository.addTax(params);
  }
}

class AddTaxRequestModel {
  final String name;
  final String rate;
  final String? id;

  AddTaxRequestModel({required this.name, required this.rate, this.id});
}

class TaxDeleteUseCase
    implements UseCase<TaxDeleteMainResModel, DeleteTaxRequestModel> {
  final TaxRepository taxRepository;
  TaxDeleteUseCase({required this.taxRepository});

  @override
  Future<Either<Failure, TaxDeleteMainResModel>> call(
      DeleteTaxRequestModel params) {
    return taxRepository.deleteTax(params);
  }
}

class DeleteTaxRequestModel {
  final String taxId;
  DeleteTaxRequestModel({required this.taxId});
}
