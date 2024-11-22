import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';

class EstimateListMainResEntity {
  int? success;
  EstimateListDataEntity? data;

  EstimateListMainResEntity({
    this.success,
    this.data,
  });
}

class EstimateListDataEntity {
  bool? success;
  List<StatusCountEntity>? statusCount;
  List<GrandtotalEntity>? grandtotal;
  Paging? paging;
  List<InvoiceEntity>? estimates;
  StatusCountEntity? statusCounts;
  String? message;

  EstimateListDataEntity({
    this.success,
    this.statusCount,
    this.grandtotal,
    this.paging,
    this.estimates,
    this.statusCounts,
    this.message,
  });
}

/*class EstimateEntity {
  String? id;
  String? date;
  DateTime? dateYmd;
  String? clientId;
  String? clientName;
  String? clientAddress;
  String? projectId;
  String? projectName;
  String? no;
  String? pono;
  String? expiryDate;
  DateTime? expirydateYmd;
  String? summary;
  String? currency;
  int? exchangeRate;
  String? subtotal;
  String? discountType;
  String? discountValue;
  String? discount;
  String? taxtotal;
  String? shipping;
  String? nettotal;
  String? formatedTotal;
  String? notes;
  String? terms;
  String? publicKey;
  String? status;
  bool? isViewed;
  String? dateViewed;
  String? invoiceId;
  String? invoiceNo;
  bool? isAttachments;
  DateTime? dateCreated;
  DateTime? dateModified;

  EstimateEntity({
    this.id,
    this.date,
    this.dateYmd,
    this.clientId,
    this.clientName,
    this.clientAddress,
    this.projectId,
    this.projectName,
    this.no,
    this.pono,
    this.expiryDate,
    this.expirydateYmd,
    this.summary,
    this.currency,
    this.exchangeRate,
    this.subtotal,
    this.discountType,
    this.discountValue,
    this.discount,
    this.taxtotal,
    this.shipping,
    this.nettotal,
    this.formatedTotal,
    this.notes,
    this.terms,
    this.publicKey,
    this.status,
    this.isViewed,
    this.dateViewed,
    this.invoiceId,
    this.invoiceNo,
    this.isAttachments,
    this.dateCreated,
    this.dateModified,
  });
}*/
