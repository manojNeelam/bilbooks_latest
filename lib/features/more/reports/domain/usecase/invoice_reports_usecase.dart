import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/reports/domain/enitites/invoice_report_entity.dart';
import 'package:billbooks_app/features/more/reports/domain/repository/report_repository.dart';
import 'package:billbooks_app/features/more/reports/presentation/model/invoice_report_model.dart';
import 'package:fpdart/fpdart.dart';

class InvoiceReportsUsecase
    implements UseCase<InvoiceReportMainResEntity, InvoiceReportReqPrarams> {
  final ReportRepository reportRepository;
  InvoiceReportsUsecase(this.reportRepository);
  @override
  Future<Either<Failure, InvoiceReportMainResEntity>> call(
      InvoiceReportReqPrarams params) {
    return reportRepository.getInvoiceReport(params);
  }
}
