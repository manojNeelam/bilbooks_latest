part of 'reports_bloc.dart';

@immutable
sealed class ReportsEvent {}

class GetInvoiceReports extends ReportsEvent {
  final InvoiceReportReqPrarams invoiceReportReqPrarams;
  GetInvoiceReports({required this.invoiceReportReqPrarams});
}

class GetOutstandingReports extends ReportsEvent {
  final OutstandingReportReqParams outstandingReportReqParams;
  GetOutstandingReports({required this.outstandingReportReqParams});
}
