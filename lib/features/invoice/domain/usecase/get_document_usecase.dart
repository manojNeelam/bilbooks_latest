import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/get_document_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../presentation/send_invoice_estimate_page.dart';

class GetDocumentUsecase
    implements UseCase<GetDocumentMainResEntity, GetDocumentUsecaseReqParams> {
  final InvoiceRepository invoiceRepository;
  GetDocumentUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, GetDocumentMainResEntity>> call(
      GetDocumentUsecaseReqParams params) {
    return invoiceRepository.getDocuments(params);
  }
}

class GetDocumentUsecaseReqParams {
  final EnumDocumentType type;
  final EnumSendPageType pageType;
  final String id;
  GetDocumentUsecaseReqParams({
    required this.type,
    required this.id,
    required this.pageType,
  });
}

enum EnumDocumentType { invoice, estimate }

extension EnumDocumentTypeExt on EnumDocumentType {
  String get name {
    switch (this) {
      case EnumDocumentType.invoice:
        return "invoice";
      case EnumDocumentType.estimate:
        return "estimate";
    }
  }
}
