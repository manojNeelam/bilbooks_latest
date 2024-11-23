import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_list_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/add_invoice_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/client_staff_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/get_document_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_delete_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_void_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/client_staff_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/delete_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_delete_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_markassend_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_void_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_details_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/send_document_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/invoice_details_model.dart';
import '../entities/add_payment_entity.dart';
import '../entities/delete_payment_entity.dart';
import '../entities/invoice_list_entity.dart';
import '../entities/invoice_marksend_entity.dart';
import '../entities/invoice_unvoice_entity.dart';
import '../entities/send_document_entity.dart';
import '../usecase/invoice_unvoid_usecase.dart';

abstract interface class InvoiceRepository {
  Future<Either<Failure, InvoiceDetailsResponseEntity>> getInvoiceDetails(
      InvoiceDetailRequest params);
  Future<Either<Failure, InvoiceListMainResEntity>> getInvoices(
      InvoiceListReqParams params);

  Future<Either<Failure, AddInvoiceMainResEntity>> addInvoice(
      AddInvoiceReqParms reqParms);

  Future<Either<Failure, PaymentListMainResEntity>> getPaymentList(
      PaymentListReqParams params);
  Future<Either<Failure, PaymentDetailMainResEntity>> getPaymentDetails(
      PaymentDetailsReqParms params);
  Future<Either<Failure, InvoiceVoidMainResEntity>> invoiceVoid(
      InvoiceVoidReqParms params);
  Future<Either<Failure, InvoiceUnVoidMainResEntity>> invoiceUnVoid(
      InvoiceUnVoidReqParms params);
  Future<Either<Failure, InvoiceMarksendMainResEntity>> invoiceMarkAsSend(
      InvoiceMarkassendReqParms params);

  Future<Either<Failure, InvoiceDeleteMainResEntity>> invoiceDelete(
      InvoiceDeleteReqParms params);
  Future<Either<Failure, ClientStaffMainResEntity>> getClientStaff(
      ClientStaffUsecaseReqParams params);

  Future<Either<Failure, GetDocumentMainResEntity>> getDocuments(
      GetDocumentUsecaseReqParams params);
  Future<Either<Failure, SendDocumentMainResEntity>> sendDocument(
      SendDocumentUsecaseReqParams params);

  Future<Either<Failure, DeletePaymentMethodMainResEntity>> deletePayment(
      DeletePaymentUsecaseReqParams params);

  Future<Either<Failure, AddPaymentMethodMainResEntity>> addPayment(
      AddPaymentUsecaseReqParms params);
}
