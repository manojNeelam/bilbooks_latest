import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_void_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/fpdart.dart';

class InvoiceVoidUsecase
    implements UseCase<InvoiceVoidMainResEntity, InvoiceVoidReqParms> {
  final InvoiceRepository invoiceRepository;
  InvoiceVoidUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, InvoiceVoidMainResEntity>> call(
      InvoiceVoidReqParms params) {
    return invoiceRepository.invoiceVoid(params);
  }
}

class InvoiceVoidReqParms {
  final String id;
  InvoiceVoidReqParms({required this.id});
}
