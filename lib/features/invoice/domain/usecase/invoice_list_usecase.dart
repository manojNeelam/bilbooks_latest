import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/fpdart.dart';

class InvoiceListUsecase
    implements UseCase<InvoiceListMainResEntity, InvoiceListReqParams> {
  final InvoiceRepository invoiceRepository;
  InvoiceListUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, InvoiceListMainResEntity>> call(
      InvoiceListReqParams params) async {
    return await invoiceRepository.getInvoices(params);
  }
}

class InvoiceListReqParams {
  final String status;
  //draft, sent,  partial, paid, overdue, unpaid, recurring, billed, void
  final String query;
  final String columnName;
  final String sortOrder;
  final String page;
  final String? startDate;
  final String? endDate;

  InvoiceListReqParams(
      {required this.status,
      required this.query,
      required this.columnName,
      required this.sortOrder,
      required this.page,
      this.startDate,
      this.endDate});
}
