import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/more/reports/domain/enitites/outstanding_report_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../presentation/model/invoice_report_model.dart';
import '../../presentation/model/outstanding_report_model.dart';
import '../enitites/invoice_report_entity.dart';

abstract interface class ReportRepository {
  Future<Either<Failure, InvoiceReportMainResEntity>> getInvoiceReport(
      InvoiceReportReqPrarams params);
  Future<Either<Failure, OutstandingReportMainResEntity>> getOutstandingReport(
      OutstandingReportReqParams params);
}
