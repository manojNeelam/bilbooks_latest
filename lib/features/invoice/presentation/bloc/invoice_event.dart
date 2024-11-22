part of 'invoice_bloc.dart';

@immutable
sealed class InvoiceEvent {}

final class GetInvoiceDetails extends InvoiceEvent {
  final InvoiceDetailRequest invoiceDetailRequest;
  GetInvoiceDetails({required this.invoiceDetailRequest});
}

final class UpdateInvoiceBasicDetails extends InvoiceEvent {
  final String? no;
  final String? heading;
  final String? title;
  UpdateInvoiceBasicDetails({this.no, this.heading, this.title});
}

final class GetInvoiceListEvent extends InvoiceEvent {
  final InvoiceListReqParams params;
  GetInvoiceListEvent({required this.params});
}

final class AddInvoiceEstimateEvent extends InvoiceEvent {
  final AddInvoiceReqParms params;
  AddInvoiceEstimateEvent({required this.params});
}

final class GetPaymentListEvent extends InvoiceEvent {
  final PaymentListReqParams params;
  GetPaymentListEvent({required this.params});
}

final class GetPaymentDetailsEvent extends InvoiceEvent {
  final PaymentDetailsReqParms paymentDetailsReqParms;
  GetPaymentDetailsEvent({required this.paymentDetailsReqParms});
}

final class InvoiceVoidEvent extends InvoiceEvent {
  final InvoiceVoidReqParms params;
  InvoiceVoidEvent({required this.params});
}

final class InvoiceUnVoidEvent extends InvoiceEvent {
  final InvoiceUnVoidReqParms params;
  InvoiceUnVoidEvent({required this.params});
}

final class InvoiceMarkAsSendEvent extends InvoiceEvent {
  final InvoiceMarkassendReqParms params;
  InvoiceMarkAsSendEvent({required this.params});
}

final class InvoiceDeleteEvent extends InvoiceEvent {
  final InvoiceDeleteReqParms params;
  InvoiceDeleteEvent({required this.params});
}

final class GetClientStaffEvent extends InvoiceEvent {
  final ClientStaffUsecaseReqParams params;
  GetClientStaffEvent({required this.params});
}

final class GetDocumentEvent extends InvoiceEvent {
  final GetDocumentUsecaseReqParams params;
  GetDocumentEvent({required this.params});
}

final class SendDocumentEvent extends InvoiceEvent {
  final SendDocumentUsecaseReqParams params;
  SendDocumentEvent({required this.params});
}

final class DeletePaymentEvent extends InvoiceEvent {
  final DeletePaymentUsecaseReqParams params;
  DeletePaymentEvent({required this.params});
}

final class AddPaymentEvent extends InvoiceEvent {
  final AddPaymentUsecaseReqParms params;
  AddPaymentEvent({required this.params});
}
