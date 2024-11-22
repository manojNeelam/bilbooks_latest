import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/get_document_entity.dart';
import '../entities/send_document_entity.dart';

class SendDocumentUsecase
    implements
        UseCase<SendDocumentMainResEntity, SendDocumentUsecaseReqParams> {
  final InvoiceRepository invoiceRepository;
  SendDocumentUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, SendDocumentMainResEntity>> call(
      SendDocumentUsecaseReqParams params) {
    return invoiceRepository.sendDocument(params);
  }
}

class SendDocumentUsecaseReqParams {
  /*
  id:100
from:2
sendto[0]:89
//sendto[1]:23478
bcc[0]:2
//bcc[1]:3221
message:Dear Samuel, Thank you! We have received your payment against invoice #10502. Best regards, Webwingz Pty ltd
subject:Payment received - Thanks 
  */
  final String id;
  final String from;
  final List<ContactEntity> bcc;
  final List<ContactEntity> sendTo;
  final String message;
  final String subject;
  final EnumDocumentType type;
  final bool isAttachPdf;

  SendDocumentUsecaseReqParams({
    required this.id,
    required this.from,
    required this.bcc,
    required this.sendTo,
    required this.message,
    required this.subject,
    required this.type,
    required this.isAttachPdf,
  });
}
