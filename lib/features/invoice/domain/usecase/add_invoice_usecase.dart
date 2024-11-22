import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/add_invoice_entity.dart';
import 'package:billbooks_app/features/invoice/domain/repository/invoice_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../project/domain/entity/project_list_entity.dart';
import '../../presentation/add_new_invoice_page.dart';
import '../entities/invoice_details_entity.dart';
import '../entities/invoice_list_entity.dart';

class AddInvoiceUsecase
    implements UseCase<AddInvoiceMainResEntity, AddInvoiceReqParms> {
  final InvoiceRepository invoiceRepository;
  AddInvoiceUsecase({required this.invoiceRepository});
  @override
  Future<Either<Failure, AddInvoiceMainResEntity>> call(
      AddInvoiceReqParms params) {
    return invoiceRepository.addInvoice(params);
  }
}

class AddInvoiceReqParms {
  final EnumNewInvoiceEstimateType type;
  final InvoiceRequestModel? invoiceRequestModel;
  final ClientEntity? selectedClient;
  final ProjectEntity? selectedProject;
  final List<EmailtoMystaffEntity> selectedMyStaffList;
  final List<EmailtoMystaffEntity> selectedClientStaff;
  final List<InvoiceItemEntity> selectedLineItems;
  final String? terms;
  final String? notes;
  final String? subTotal;
  final String? discountType;
  final String? discountValue;
  final String? discount;
  final String? taxTotal;
  final String? shipping;
  final String? netTotal;
  final String? id;

  AddInvoiceReqParms({
    required this.type,
    this.invoiceRequestModel,
    this.selectedClient,
    this.selectedProject,
    required this.selectedMyStaffList,
    required this.selectedClientStaff,
    required this.selectedLineItems,
    this.terms,
    this.notes,
    required this.discount,
    required this.discountType,
    required this.discountValue,
    required this.netTotal,
    required this.shipping,
    required this.subTotal,
    required this.taxTotal,
    required this.id,
  });
}
