import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_unvoice_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/fpdart.dart';

class InvoiceUnvoidUsecase
    implements UseCase<InvoiceUnVoidMainResEntity, InvoiceUnVoidReqParms> {
  final InvoiceRepository invoiceRepository;
  InvoiceUnvoidUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, InvoiceUnVoidMainResEntity>> call(
      InvoiceUnVoidReqParms params) {
    return invoiceRepository.invoiceUnVoid(params);
  }
}

class InvoiceUnVoidReqParms {
  final String id;
  InvoiceUnVoidReqParms({required this.id});
}
