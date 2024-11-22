import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_delete_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:fpdart/fpdart.dart';

class InvoiceDeleteUsecase
    implements UseCase<InvoiceDeleteMainResEntity, InvoiceDeleteReqParms> {
  final InvoiceRepository invoiceRepository;
  InvoiceDeleteUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, InvoiceDeleteMainResEntity>> call(
      InvoiceDeleteReqParms params) {
    return invoiceRepository.invoiceDelete(params);
  }
}

class InvoiceDeleteReqParms {
  final String id;
  final EnumDocumentType type;
  InvoiceDeleteReqParms({
    required this.id,
    required this.type,
  });
}
