import 'package:billbooks_app/features/invoice/domain/entities/add_payment_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/client_staff_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/get_document_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_delete_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_marksend_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_void_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/send_document_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/client_staff_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/delete_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_markassend_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_void_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_details_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/send_document_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/add_invoice_entity.dart';
import '../../domain/entities/delete_payment_entity.dart';
import '../../domain/entities/invoice_unvoice_entity.dart';
import '../../domain/usecase/add_invoice_usecase.dart';
import '../../domain/usecase/invoice_delete_usecase.dart';
import '../../domain/usecase/invoice_unvoid_usecase.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceDetailUsecase _invoiceDetailUsecase;
  final InvoiceListUsecase _invoiceListUsecase;
  final PaymentListUsecase _paymentListUsecase;
  final PaymentDetailsUsecase _paymentDetailsUsecase;
  final InvoiceVoidUsecase _invoiceVoidUsecase;
  final InvoiceUnvoidUsecase _invoiceUnvoidUsecase;
  final InvoiceMarkassendUsecase _invoiceMarkassendUsecase;
  final InvoiceDeleteUsecase _invoiceDeleteUsecase;
  final AddInvoiceUsecase _addInvoiceUsecase;
  final ClientStaffUsecase _clientStaffUsecase;
  final GetDocumentUsecase _getDocumentUsecase;
  final DeletePaymentUsecase _deletePaymentUsecase;
  final AddPaymentUsecase _addPaymentUsecase;
  final SendDocumentUsecase _sendDocumentUsecase;

  InvoiceBloc({
    required InvoiceDetailUsecase invoiceDetailUsecase,
    required InvoiceListUsecase invoiceListUsecase,
    required PaymentListUsecase paymentListUsecase,
    required PaymentDetailsUsecase paymentDetailsUsecase,
    required InvoiceVoidUsecase invoiceVoidUsecase,
    required InvoiceUnvoidUsecase invoiceUnvoidUsecase,
    required InvoiceMarkassendUsecase invoiceMarkassendUsecase,
    required InvoiceDeleteUsecase invoiceDeleteUsecase,
    required AddInvoiceUsecase addInvoiceUsecase,
    required ClientStaffUsecase clientStaffUsecase,
    required GetDocumentUsecase getDocumentUsecase,
    required DeletePaymentUsecase deletePaymentUsecase,
    required AddPaymentUsecase addPaymentUsecase,
    required SendDocumentUsecase sendDocumentUsecase,
  })  : _invoiceDetailUsecase = invoiceDetailUsecase,
        _invoiceListUsecase = invoiceListUsecase,
        _paymentListUsecase = paymentListUsecase,
        _paymentDetailsUsecase = paymentDetailsUsecase,
        _invoiceVoidUsecase = invoiceVoidUsecase,
        _invoiceUnvoidUsecase = invoiceUnvoidUsecase,
        _invoiceMarkassendUsecase = invoiceMarkassendUsecase,
        _invoiceDeleteUsecase = invoiceDeleteUsecase,
        _addInvoiceUsecase = addInvoiceUsecase,
        _clientStaffUsecase = clientStaffUsecase,
        _getDocumentUsecase = getDocumentUsecase,
        _deletePaymentUsecase = deletePaymentUsecase,
        _addPaymentUsecase = addPaymentUsecase,
        _sendDocumentUsecase = sendDocumentUsecase,
        super(InvoiceInitial()) {
    on<GetInvoiceDetails>((event, emit) async {
      emit(InvoiceDetailsLoadingState());
      final response =
          await _invoiceDetailUsecase.call(event.invoiceDetailRequest);
      debugPrint("invoicedeatisl response $response");
      response.fold(
          (l) => emit(InvoiceDetailsFailureState(errorMessage: l.message)),
          (r) =>
              emit(InvoiceDetailSuccessState(invoiceDetailResEntity: r.data!)));
    });

    on<UpdateInvoiceBasicDetails>((event, emit) {
      emit(InvoiceBasicDetailState(
          invoiceRequestModel: InvoiceRequestModel(
              no: event.no, heading: event.heading, title: event.title)));
    });

    on<GetInvoiceListEvent>((event, emit) async {
      emit(InvoiceListLoadingState());
      final response = await _invoiceListUsecase.call(event.params);
      response.fold(
          (l) => emit(InvoiceListFailureState(errorMessage: l.message)),
          (r) => emit(InvoiceListSuccessState(invoiceListMainResEntity: r)));
    });

    on<GetPaymentListEvent>((event, emit) async {
      emit(PaymentListLoadingState());
      final response = await _paymentListUsecase.call(event.params);
      response.fold(
        (l) => emit(PaymentListErrorState(errorMessage: l.message)),
        (r) => emit(PaymentListSuccessState(paymentListMainResEntity: r)),
      );
    });

    on<GetPaymentDetailsEvent>((event, emit) async {
      emit(PaymentDetailLoadingState());
      final response =
          await _paymentDetailsUsecase.call(event.paymentDetailsReqParms);
      response.fold(
          (l) => emit(PaymentDetailErrorState(errorMessage: l.message)),
          (r) =>
              emit(PaymentDetailSuccessState(paymentDetailMainResEntity: r)));
    });

    on<InvoiceVoidEvent>((event, emit) async {
      emit(InvoiceVoidLoadingState());
      final response = await _invoiceVoidUsecase.call(event.params);
      response.fold((l) => emit(InvoiceVoidErrorState(errorMessage: l.message)),
          (r) => emit(InvoiceVoidSuccessState(invoiceVoidMainResEntity: r)));
    });

    on<InvoiceUnVoidEvent>((event, emit) async {
      emit(InvoiceUnVoidLoadingState());
      final response = await _invoiceUnvoidUsecase.call(event.params);
      response.fold(
          (l) => emit(InvoiceUnVoidErrorState(errorMessage: l.message)),
          (r) =>
              emit(InvoiceUnVoidSuccessState(invoiceUnVoidMainResEntity: r)));
    });

    on<InvoiceMarkAsSendEvent>((event, emit) async {
      emit(InvoiceMarkAsSendLoadingState());
      final response = await _invoiceMarkassendUsecase.call(event.params);
      response.fold(
          (l) => emit(InvoiceMarkAsSendErrorState(errorMessage: l.message)),
          (r) => emit(
              InvoiceMarkAsSendSuccessState(invoiceMarksendMainResEntity: r)));
    });

    on<InvoiceDeleteEvent>((event, emit) async {
      emit(InvoiceDeleteLoadingState());
      final response = await _invoiceDeleteUsecase.call(event.params);
      response.fold(
          (l) => emit(InvoiceDeleteErrorState(errorMessage: l.message)),
          (r) =>
              emit(InvoiceDeleteSuccessState(invoiceDeleteMainResEntity: r)));
    });

    on<AddInvoiceEstimateEvent>((event, emit) async {
      emit(InvoiceEstimateAddLoadingState());
      final response = await _addInvoiceUsecase.call(event.params);
      response.fold(
          (l) => emit(InvoiceEstimateAddErrorState(errorMessage: l.message)),
          (r) =>
              emit(InvoiceEstimateAddSuccessState(addInvoiceMainResEntity: r)));
    });

    on<GetClientStaffEvent>((event, emit) async {
      emit(ClientStaffLoadingState());
      final response = await _clientStaffUsecase.call(event.params);
      response.fold((l) => emit(ClientStaffErrorState(errorMessage: l.message)),
          (r) => emit(ClientStaffSuccessState(clientStaffMainResEntity: r)));
    });

    on<GetDocumentEvent>((event, emit) async {
      emit(GetDocumentLoadingState());
      final response = await _getDocumentUsecase.call(event.params);
      response.fold((l) => emit(GetDocumentErrorState(errorMessage: l.message)),
          (r) => emit(GetDocumentSuccessState(documentMainResEntity: r)));
    });

    on<DeletePaymentEvent>((event, emit) async {
      emit(DeletePaymentLoadingState());
      final response = await _deletePaymentUsecase.call(event.params);
      response.fold(
          (l) => emit(DeletePaymentErrorState(errorMessage: l.message)),
          (r) => emit(
              DeletePaymentSuccessState(deletePaymentMethodMainResEntity: r)));
    });

    on<AddPaymentEvent>((event, emit) async {
      emit(AddPaymentLoadingState());
      final response = await _addPaymentUsecase.call(event.params);
      response.fold(
          (l) => emit(AddPaymentErrorState(errorMessage: l.message)),
          (r) =>
              emit(AddPaymentSuccessState(addPaymentMethodMainResEntity: r)));
    });

    on<SendDocumentEvent>((event, emit) async {
      emit(SendDocumentLoadingState());
      final response = await _sendDocumentUsecase.call(event.params);
      response.fold(
          (l) => emit(SendDocumentErrorState(errorMessage: l.message)),
          (r) => emit(SendDocumentSuccessState(sendDocumentMainResEntity: r)));
    });
  }
}
