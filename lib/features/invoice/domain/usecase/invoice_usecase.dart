import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/core/usecase/usecase.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/invoice_details_model.dart';
import '../entities/invoice_details_entity.dart';

class InvoiceDetailUsecase
    implements UseCase<InvoiceDetailsResponseEntity, InvoiceDetailRequest> {
  final InvoiceRepository invoiceRepository;

  InvoiceDetailUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, InvoiceDetailsResponseEntity>> call(
      InvoiceDetailRequest params) async {
    return await invoiceRepository.getInvoiceDetails(params);
  }
}

class InvoiceDetailRequest {
  final String? id;
  final EnumNewInvoiceEstimateType type;
  InvoiceDetailRequest({this.id, required this.type});
}
