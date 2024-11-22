part of 'invoice_bloc.dart';

@immutable
sealed class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}

final class InvoiceDetailSuccessState extends InvoiceState {
  final InvoiceDetailResEntity invoiceDetailResEntity;
  InvoiceDetailSuccessState({required this.invoiceDetailResEntity});
}

final class InvoiceDetailsFailureState extends InvoiceState {
  final String errorMessage;
  InvoiceDetailsFailureState({required this.errorMessage});
}

final class InvoiceDetailsLoadingState extends InvoiceState {}

final class InvoiceBasicDetailState extends InvoiceState {
  final InvoiceRequestModel invoiceRequestModel;
  InvoiceBasicDetailState({required this.invoiceRequestModel});
}

// Invoice List States
final class InvoiceListFailureState extends InvoiceState {
  final String errorMessage;
  InvoiceListFailureState({required this.errorMessage});
}

final class InvoiceListLoadingState extends InvoiceState {}

final class InvoiceListSuccessState extends InvoiceState {
  final InvoiceListMainResEntity invoiceListMainResEntity;
  InvoiceListSuccessState({required this.invoiceListMainResEntity});
}
// Invoice List States

// START Get Payment List States
final class PaymentListLoadingState extends InvoiceState {}

final class PaymentListErrorState extends InvoiceState {
  final String errorMessage;
  PaymentListErrorState({required this.errorMessage});
}

final class PaymentListSuccessState extends InvoiceState {
  final PaymentListMainResEntity paymentListMainResEntity;
  PaymentListSuccessState({required this.paymentListMainResEntity});
}
// END Get Payment List States

// START Get Payment Details States
final class PaymentDetailLoadingState extends InvoiceState {}

final class PaymentDetailErrorState extends InvoiceState {
  final String errorMessage;
  PaymentDetailErrorState({required this.errorMessage});
}

final class PaymentDetailSuccessState extends InvoiceState {
  final PaymentDetailMainResEntity paymentDetailMainResEntity;
  PaymentDetailSuccessState({required this.paymentDetailMainResEntity});
}
// END Get Payment Details States

// START  Invoice Void States
final class InvoiceVoidLoadingState extends InvoiceState {}

final class InvoiceVoidErrorState extends InvoiceState {
  final String errorMessage;
  InvoiceVoidErrorState({required this.errorMessage});
}

final class InvoiceVoidSuccessState extends InvoiceState {
  final InvoiceVoidMainResEntity invoiceVoidMainResEntity;
  InvoiceVoidSuccessState({required this.invoiceVoidMainResEntity});
}
// END Invoice Void States

// START  Invoice unVoid States
final class InvoiceUnVoidLoadingState extends InvoiceState {}

final class InvoiceUnVoidErrorState extends InvoiceState {
  final String errorMessage;
  InvoiceUnVoidErrorState({required this.errorMessage});
}

final class InvoiceUnVoidSuccessState extends InvoiceState {
  final InvoiceUnVoidMainResEntity invoiceUnVoidMainResEntity;
  InvoiceUnVoidSuccessState({required this.invoiceUnVoidMainResEntity});
}
// END Invoice Void States

// START  Invoice Mark as send States
final class InvoiceMarkAsSendLoadingState extends InvoiceState {}

final class InvoiceMarkAsSendErrorState extends InvoiceState {
  final String errorMessage;
  InvoiceMarkAsSendErrorState({required this.errorMessage});
}

final class InvoiceMarkAsSendSuccessState extends InvoiceState {
  final InvoiceMarksendMainResEntity invoiceMarksendMainResEntity;
  InvoiceMarkAsSendSuccessState({required this.invoiceMarksendMainResEntity});
}
// END Invoice Mark as send States

// START  Invoice Delete States
final class InvoiceDeleteLoadingState extends InvoiceState {}

final class InvoiceDeleteErrorState extends InvoiceState {
  final String errorMessage;
  InvoiceDeleteErrorState({required this.errorMessage});
}

final class InvoiceDeleteSuccessState extends InvoiceState {
  final InvoiceDeleteMainResEntity invoiceDeleteMainResEntity;
  InvoiceDeleteSuccessState({required this.invoiceDeleteMainResEntity});
}
// END Invoice Delete States

// START  Invoice Add States
final class InvoiceEstimateAddLoadingState extends InvoiceState {}

final class InvoiceEstimateAddErrorState extends InvoiceState {
  final String errorMessage;
  InvoiceEstimateAddErrorState({required this.errorMessage});
}

final class InvoiceEstimateAddSuccessState extends InvoiceState {
  final AddInvoiceMainResEntity addInvoiceMainResEntity;
  InvoiceEstimateAddSuccessState({required this.addInvoiceMainResEntity});
}
// END Invoice Add States

// START  Client Staff
final class ClientStaffLoadingState extends InvoiceState {}

final class ClientStaffErrorState extends InvoiceState {
  final String errorMessage;
  ClientStaffErrorState({required this.errorMessage});
}

final class ClientStaffSuccessState extends InvoiceState {
  final ClientStaffMainResEntity clientStaffMainResEntity;
  ClientStaffSuccessState({required this.clientStaffMainResEntity});
}
// END Client Staff

// START  Document
final class GetDocumentLoadingState extends InvoiceState {}

final class GetDocumentErrorState extends InvoiceState {
  final String errorMessage;
  GetDocumentErrorState({required this.errorMessage});
}

final class GetDocumentSuccessState extends InvoiceState {
  final GetDocumentMainResEntity documentMainResEntity;
  GetDocumentSuccessState({required this.documentMainResEntity});
}
// END Docment

// START  Delete Payment
final class DeletePaymentLoadingState extends InvoiceState {}

final class DeletePaymentErrorState extends InvoiceState {
  final String errorMessage;
  DeletePaymentErrorState({required this.errorMessage});
}

final class DeletePaymentSuccessState extends InvoiceState {
  final DeletePaymentMethodMainResEntity deletePaymentMethodMainResEntity;
  DeletePaymentSuccessState({required this.deletePaymentMethodMainResEntity});
}
// END Delete Payment

// START Add Payment
final class AddPaymentLoadingState extends InvoiceState {}

final class AddPaymentErrorState extends InvoiceState {
  final String errorMessage;
  AddPaymentErrorState({required this.errorMessage});
}

final class AddPaymentSuccessState extends InvoiceState {
  final AddPaymentMethodMainResEntity addPaymentMethodMainResEntity;
  AddPaymentSuccessState({required this.addPaymentMethodMainResEntity});
}
// END Add Payment

// START Send Doc
final class SendDocumentLoadingState extends InvoiceState {}

final class SendDocumentErrorState extends InvoiceState {
  final String errorMessage;
  SendDocumentErrorState({required this.errorMessage});
}

final class SendDocumentSuccessState extends InvoiceState {
  final SendDocumentMainResEntity sendDocumentMainResEntity;
  SendDocumentSuccessState({required this.sendDocumentMainResEntity});
}
// END Send Doc
