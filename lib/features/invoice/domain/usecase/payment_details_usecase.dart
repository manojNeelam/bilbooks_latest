import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/fpdart.dart';

class PaymentDetailsUsecase
    implements UseCase<PaymentDetailMainResEntity, PaymentDetailsReqParms> {
  final InvoiceRepository invoiceRepository;
  PaymentDetailsUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, PaymentDetailMainResEntity>> call(
      PaymentDetailsReqParms params) {
    return invoiceRepository.getPaymentDetails(params);
  }
}

class PaymentDetailsReqParms {
  final String id;
  PaymentDetailsReqParms({required this.id});
}
