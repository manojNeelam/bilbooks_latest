import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_list_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/invoice_repository.dart';

class PaymentListUsecase
    implements UseCase<PaymentListMainResEntity, PaymentListReqParams> {
  final InvoiceRepository invoiceRepository;
  PaymentListUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, PaymentListMainResEntity>> call(
      PaymentListReqParams params) {
    return invoiceRepository.getPaymentList(params);
  }
}

class PaymentListReqParams {
  final String id;
  PaymentListReqParams({required this.id});
}
