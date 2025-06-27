import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/more/reports/domain/enitites/outstanding_report_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../presentation/model/outstanding_report_model.dart';
import '../repository/report_repository.dart';

class OutstandingReportUsecase
    implements
        UseCase<OutstandingReportMainResEntity, OutstandingReportReqParams> {
  final ReportRepository reportRepository;
  OutstandingReportUsecase({required this.reportRepository});
  @override
  Future<Either<Failure, OutstandingReportMainResEntity>> call(
      OutstandingReportReqParams params) {
    return reportRepository.getOutstandingReport(params);
  }
}
