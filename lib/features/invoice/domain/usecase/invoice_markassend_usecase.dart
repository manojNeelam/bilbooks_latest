import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_marksend_entity.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/invoice_repository.dart';

class InvoiceMarkassendUsecase
    implements
        UseCase<InvoiceMarksendMainResEntity, InvoiceMarkassendReqParms> {
  final InvoiceRepository invoiceRepository;
  InvoiceMarkassendUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, InvoiceMarksendMainResEntity>> call(
      InvoiceMarkassendReqParms params) {
    return invoiceRepository.invoiceMarkAsSend(params);
  }
}

class InvoiceMarkassendReqParms {
  final EnumNewInvoiceEstimateType type;
  final String id;
  InvoiceMarkassendReqParms({
    required this.id,
    required this.type,
  });
}
