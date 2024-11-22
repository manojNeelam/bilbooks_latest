import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/delete_payment_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/src/either.dart';

import '../entities/invoice_delete_entity.dart';

class DeletePaymentUsecase
    implements
        UseCase<DeletePaymentMethodMainResEntity,
            DeletePaymentUsecaseReqParams> {
  final InvoiceRepository invoiceRepository;
  DeletePaymentUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, DeletePaymentMethodMainResEntity>> call(
      DeletePaymentUsecaseReqParams params) {
    return invoiceRepository.deletePayment(params);
  }
}

class DeletePaymentUsecaseReqParams {
  final String id;
  DeletePaymentUsecaseReqParams({required this.id});
}
