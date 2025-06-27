import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/more/reports/domain/enitites/invoice_report_entity.dart';
import 'package:billbooks_app/features/more/reports/domain/enitites/outstanding_report_entity.dart';
import 'package:billbooks_app/features/more/reports/presentation/model/outstanding_report_model.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/api/api_exception.dart';
import '../../domain/repository/report_repository.dart';
import '../../presentation/model/invoice_report_model.dart';
import '../datasource/remote/reports_remote_datasource.dart';

final class ReportsRepositoryImpl implements ReportRepository {
  final ReportsRemoteDatasource remoteDatasource;
  ReportsRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, InvoiceReportMainResEntity>> getInvoiceReport(
      InvoiceReportReqPrarams params) async {
    try {
      final res = await remoteDatasource.getInvoiceReport(params);
      debugPrint("getInvoiceReport: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("getInvoiceReport: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("getInvoiceReport: default error");
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OutstandingReportMainResEntity>> getOutstandingReport(
      OutstandingReportReqParams params) async {
    try {
      final res = await remoteDatasource.getOutstandingReport(params);
      debugPrint("getOutstandingReport: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("getInvoiceReport: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("getInvoiceReport: default error");
      return left(Failure(e.toString()));
    }
  }
}
