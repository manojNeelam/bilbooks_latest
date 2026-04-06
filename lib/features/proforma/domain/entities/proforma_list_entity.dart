import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';

import '../../../clients/domain/entities/client_list_entity.dart';

class ProformaListMainResEntity {
  int? success;
  ProformaListDataEntity? data;

  ProformaListMainResEntity({
    this.success,
    this.data,
  });
}

class ProformaListDataEntity {
  bool? success;
  List<ProformaStatusCountEntity>? statusCount;
  List<ProformaGrandtotalEntity>? grandtotal;
  Paging? paging;
  List<ProformaEntity>? proformas;
  String? message;

  ProformaListDataEntity({
    this.success,
    this.statusCount,
    this.grandtotal,
    this.paging,
    this.proformas,
    this.message,
  });
}

class ProformaStatusCountEntity {
  String? allcount;
  String? draft;
  String? sent;
  String? approved;
  String? declined;

  ProformaStatusCountEntity({
    this.allcount,
    this.draft,
    this.sent,
    this.approved,
    this.declined,
  });
}

class ProformaGrandtotalEntity {
  String? currency;
  String? total;
  String? baltotal;
  String? formatedAmt;
  String? formatedAmtbal;

  ProformaGrandtotalEntity({
    this.currency,
    this.total,
    this.baltotal,
    this.formatedAmt,
    this.formatedAmtbal,
  });
}

class ProformaEntity {
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
  String? expirydateYmd;
  String? summary;
  String? currency;
  String? currencySymbol;
  dynamic exchangeRate;
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
  String? heading;
  String? status;
  String? dueTerms;
  String? dueDate;
  String? overdueDays;
  String? overdueText;
  String? paymentReminders;
  String? paid;
  String? formatedPaid;
  String? balance;
  String? formatedBalance;

  ProformaEntity({
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
    this.currencySymbol,
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
    this.heading,
    this.status,
    this.dueTerms,
    this.dueDate,
    this.overdueDays,
    this.overdueText,
    this.paymentReminders,
    this.paid,
    this.formatedPaid,
    this.balance,
    this.formatedBalance,
  });

  factory ProformaEntity.fromInvoiceEntity(InvoiceEntity invoice) {
    return ProformaEntity(
      id: invoice.id,
      date: invoice.date,
      dateYmd: invoice.dateYmd,
      clientId: invoice.clientId,
      clientName: invoice.clientName,
      clientAddress: invoice.clientAddress,
      projectId: invoice.projectId,
      projectName: invoice.projectName,
      no: invoice.no,
      pono: invoice.pono,
      expiryDate: invoice.expiryDate,
      expirydateYmd: invoice.expirydateYmd,
      summary: invoice.summary,
      currency: invoice.currency,
      currencySymbol: invoice.currencySymbol,
      exchangeRate: invoice.exchangeRate,
      subtotal: invoice.subtotal,
      discountType: invoice.discountType,
      discountValue: invoice.discountValue,
      discount: invoice.discount,
      taxtotal: invoice.taxtotal,
      shipping: invoice.shipping,
      nettotal: invoice.nettotal,
      formatedTotal: invoice.formatedTotal,
      notes: invoice.notes,
      terms: invoice.terms,
      heading: invoice.heading,
      status: invoice.status,
      dueTerms: invoice.dueTerms,
      dueDate: invoice.dueDate,
      overdueDays: invoice.overdueDays,
      overdueText: invoice.overdueText,
      paymentReminders: invoice.paymentReminders,
      paid: invoice.paid,
      formatedPaid: invoice.formatedPaid,
      balance: invoice.balance,
      formatedBalance: invoice.formatedBalance,
    );
  }

  InvoiceEntity toInvoiceEntity() {
    return InvoiceEntity(
      id: id,
      date: date,
      dateYmd: dateYmd,
      clientId: clientId,
      clientName: clientName,
      clientAddress: clientAddress,
      projectId: projectId,
      projectName: projectName,
      no: no,
      pono: pono,
      expiryDate: expiryDate,
      expirydateYmd: expirydateYmd,
      summary: summary,
      currency: currency,
      currencySymbol: currencySymbol,
      exchangeRate: exchangeRate,
      subtotal: subtotal,
      discountType: discountType,
      discountValue: discountValue,
      discount: discount,
      taxtotal: taxtotal,
      shipping: shipping,
      nettotal: nettotal,
      formatedTotal: formatedTotal,
      notes: notes,
      terms: terms,
      heading: heading,
      status: status,
      dueTerms: dueTerms,
      dueDate: dueDate,
      overdueDays: overdueDays,
      overdueText: overdueText,
      paymentReminders: paymentReminders,
      paid: paid,
      formatedPaid: formatedPaid,
      balance: balance,
      formatedBalance: formatedBalance,
    );
  }
}
