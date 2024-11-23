import 'dart:async';

import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/invoice/data/datasource/remote/invoice_remote_datasource.dart';
import 'package:billbooks_app/features/invoice/domain/entities/add_invoice_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/client_staff_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/get_document_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_delete_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_marksend_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_unvoice_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_void_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/send_document_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/delete_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_delete_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_markassend_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_unvoid_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_void_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_details_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/send_document_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/add_payment_entity.dart';
import '../../domain/entities/delete_payment_entity.dart';
import '../../domain/entities/invoice_details_entity.dart';
import '../../domain/entities/invoice_list_entity.dart';
import '../../domain/usecase/client_staff_usecase.dart';
import '../../domain/usecase/invoice_list_usecase.dart';
import '../models/invoice_details_model.dart';
import '../models/invoice_list_model.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceRemoteDatasource invoiceRemoteDatasource;
  InvoiceRepositoryImpl({required this.invoiceRemoteDatasource});
  @override
  Future<Either<Failure, InvoiceDetailsResponseEntity>> getInvoiceDetails(
      InvoiceDetailRequest params) async {
    try {
      final invoiceDetailResData =
          await invoiceRemoteDatasource.getInvoiceDetails(params);
      return right(invoiceDetailResData);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceListMainResEntity>> getInvoices(
      InvoiceListReqParams params) async {
    try {
      final invoiceDetailResData =
          await invoiceRemoteDatasource.getInvoices(params);
      return right(invoiceDetailResData);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddInvoiceMainResEntity>> addInvoice(
      AddInvoiceReqParms reqParms) async {
    try {
      final responseBody = await invoiceRemoteDatasource.addInvoices(reqParms);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentListMainResEntity>> getPaymentList(
      PaymentListReqParams params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.getPaymentList(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentDetailMainResEntity>> getPaymentDetails(
      PaymentDetailsReqParms params) async {
    try {
      final responseBody =
          await invoiceRemoteDatasource.getPaymentDetails(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceVoidMainResEntity>> invoiceVoid(
      InvoiceVoidReqParms params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.invoiceVoid(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceUnVoidMainResEntity>> invoiceUnVoid(
      InvoiceUnVoidReqParms params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.invoiceUnVoid(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceMarksendMainResEntity>> invoiceMarkAsSend(
      InvoiceMarkassendReqParms params) async {
    try {
      final responseBody =
          await invoiceRemoteDatasource.invoiceMarkSend(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceDeleteMainResEntity>> invoiceDelete(
      InvoiceDeleteReqParms params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.deleteInvoice(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientStaffMainResEntity>> getClientStaff(
      ClientStaffUsecaseReqParams params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.getClientStaff(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetDocumentMainResEntity>> getDocuments(
      GetDocumentUsecaseReqParams params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.getDocuments(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeletePaymentMethodMainResEntity>> deletePayment(
      DeletePaymentUsecaseReqParams params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.deletePayment(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddPaymentMethodMainResEntity>> addPayment(
      AddPaymentUsecaseReqParms params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.addPayment(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SendDocumentMainResEntity>> sendDocument(
      SendDocumentUsecaseReqParams params) async {
    try {
      final responseBody = await invoiceRemoteDatasource.sendDocuments(params);
      return right(responseBody);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
