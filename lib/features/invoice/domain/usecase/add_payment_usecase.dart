import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/add_payment_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_delete_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/src/either.dart';

class AddPaymentUsecase
    implements
        UseCase<AddPaymentMethodMainResEntity, AddPaymentUsecaseReqParms> {
  final InvoiceRepository invoiceRepository;
  AddPaymentUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, AddPaymentMethodMainResEntity>> call(
      AddPaymentUsecaseReqParms params) {
    return invoiceRepository.addPayment(params);
  }
}

class AddPaymentUsecaseReqParms {
  final String date, amount, invoiceId, method, refno, notes;
  final bool sendThankYou;
  final String? id;
  AddPaymentUsecaseReqParms(
      {this.id,
      required this.sendThankYou,
      required this.method,
      required this.refno,
      required this.notes,
      required this.date,
      required this.amount,
      required this.invoiceId});
  /*
  date:2022-17-10
amount:500
invoice_id:89018
method:card
refno:xyz2525
notes:test
date_created:2022-17-10
date_modified:2022-17-10
id:79584
send_thankyou:false
sendto:
  */
}
