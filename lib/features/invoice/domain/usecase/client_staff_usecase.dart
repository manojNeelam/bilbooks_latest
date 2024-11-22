import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/client_staff_entity.dart';

class ClientStaffUsecase
    implements UseCase<ClientStaffMainResEntity, ClientStaffUsecaseReqParams> {
  final InvoiceRepository invoiceRepository;
  ClientStaffUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, ClientStaffMainResEntity>> call(
      ClientStaffUsecaseReqParams params) {
    return invoiceRepository.getClientStaff(params);
  }
}

class ClientStaffUsecaseReqParams {
  final String id;
  ClientStaffUsecaseReqParams({required this.id});
}
