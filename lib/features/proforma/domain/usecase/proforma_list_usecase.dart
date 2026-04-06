import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_details_entity.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_list_entity.dart';
import 'package:billbooks_app/features/proforma/domain/repository/proforma_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProformaListUsecase
    implements UseCase<ProformaListMainResEntity, ProformaListReqParams> {
  final ProformaRepository proformaRepository;
  ProformaListUsecase({required this.proformaRepository});

  @override
  Future<Either<Failure, ProformaListMainResEntity>> call(
      ProformaListReqParams params) async {
    return await proformaRepository.getProformas(params);
  }
}

class ProformaListReqParams {
  final String status;
  final String query;
  final String columnName;
  final String sortOrder;
  final String page;
  final String? startDate;
  final String? endDate;

  ProformaListReqParams({
    required this.status,
    required this.query,
    required this.columnName,
    required this.sortOrder,
    required this.page,
    this.startDate,
    this.endDate,
  });
}

class GetProformaDetailsUsecase
    implements
        UseCase<ProformaDetailsResponseEntity, ProformaDetailsReqParams> {
  final ProformaRepository proformaRepository;

  GetProformaDetailsUsecase({required this.proformaRepository});

  @override
  Future<Either<Failure, ProformaDetailsResponseEntity>> call(
      ProformaDetailsReqParams params) async {
    return await proformaRepository.getProformaDetails(params);
  }
}

class ProformaDetailsReqParams {
  final String id;
  final String duplicate;

  ProformaDetailsReqParams({
    this.id = "0",
    this.duplicate = "",
  });
}
