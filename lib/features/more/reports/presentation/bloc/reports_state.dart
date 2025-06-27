part of 'reports_bloc.dart';

@immutable
sealed class ReportsState {}

final class ReportsInitial extends ReportsState {}

class InvoiceReportLoadingState extends ReportsState {}

class InvoiceReportErrorState extends ReportsState {
  final String errorMessage;
  InvoiceReportErrorState({required this.errorMessage});
}

class InvoiceReportSuccessState extends ReportsState {
  final InvoiceReportMainResEntity invoiceReportMainResEntity;
  InvoiceReportSuccessState({required this.invoiceReportMainResEntity});
}

class OutstandingReportLoadingState extends ReportsState {}

class OutstandingReportErrorState extends ReportsState {
  final String errorMessage;
  OutstandingReportErrorState({required this.errorMessage});
}

class OutstandingReportSuccessState extends ReportsState {
  final OutstandingReportMainResEntity outstandingReportMainResEntity;
  OutstandingReportSuccessState({required this.outstandingReportMainResEntity});
}
