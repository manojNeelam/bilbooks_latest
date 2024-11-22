import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/overdue_invoice_entity.dart';
import '../repository/dashboard_repository.dart';

class OverdueInvoiceUsecase
    implements
        UseCase<OverdueInvoiceMainResEntity, OverdueInvoiceUsecaseReqParams> {
  final DashboardRepository dashboardRepository;
  OverdueInvoiceUsecase({required this.dashboardRepository});
  @override
  Future<Either<Failure, OverdueInvoiceMainResEntity>> call(
      OverdueInvoiceUsecaseReqParams params) {
    return dashboardRepository.getOverdueInvoices(params);
  }
}

class OverdueInvoiceUsecaseReqParams {}
