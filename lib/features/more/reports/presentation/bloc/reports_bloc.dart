import 'package:billbooks_app/features/more/reports/domain/usecase/outstanding_report_usecase.dart';
import 'package:billbooks_app/features/more/reports/presentation/model/outstanding_report_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/enitites/invoice_report_entity.dart';
import '../../domain/enitites/outstanding_report_entity.dart';
import '../../domain/usecase/invoice_reports_usecase.dart';
import '../model/invoice_report_model.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final InvoiceReportsUsecase _invoiceReportsUsecase;
  final OutstandingReportUsecase _outstandingReportUsecase;
  ReportsBloc({
    required InvoiceReportsUsecase invoiceReportsUsecase,
    required OutstandingReportUsecase outstandingReportUsecase,
  })  : _invoiceReportsUsecase = invoiceReportsUsecase,
        _outstandingReportUsecase = outstandingReportUsecase,
        super(ReportsInitial()) {
    on<GetInvoiceReports>((event, emit) async {
      emit(InvoiceReportLoadingState());

      final response =
          await _invoiceReportsUsecase.call(event.invoiceReportReqPrarams);
      response.fold(
          (l) => emit(InvoiceReportErrorState(errorMessage: l.message)),
          (r) =>
              emit(InvoiceReportSuccessState(invoiceReportMainResEntity: r)));
    });

    on<GetOutstandingReports>((event, emit) async {
      emit(OutstandingReportLoadingState());

      final response = await _outstandingReportUsecase
          .call(event.outstandingReportReqParams);
      response.fold(
          (l) => emit(OutstandingReportErrorState(errorMessage: l.message)),
          (r) => emit(OutstandingReportSuccessState(
              outstandingReportMainResEntity: r)));
    });
  }
}
