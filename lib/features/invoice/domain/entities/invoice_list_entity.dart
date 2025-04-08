// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final invoiceListMainResEntity = invoiceListMainResEntityFromJson(jsonString);

import 'dart:ui';

import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/escape_html_code.dart';
import 'invoice_details_entity.dart';

class InvoiceListMainResEntity {
  int? success;
  InvoiceListDataEntity? data;

  InvoiceListMainResEntity({
    this.success,
    this.data,
  });
}

class InvoiceListDataEntity {
  bool? success;
  List<InvoiceListStatusCountEntity>? statusCount;
  List<GrandtotalEntity>? grandtotal;
  Paging? paging;
  List<InvoiceEntity>? invoices;
  InvoieListStatusCountsEntity? statusCounts;
  String? message;

  InvoiceListDataEntity({
    this.success,
    this.statusCount,
    this.grandtotal,
    this.paging,
    this.invoices,
    this.statusCounts,
    this.message,
  });
}

class GrandtotalEntity {
  String? currency;
  String? total;
  String? baltotal;
  String? formatedAmt;
  String? formatedAmtbal;

  GrandtotalEntity({
    this.currency,
    this.total,
    this.baltotal,
    this.formatedAmt,
    this.formatedAmtbal,
  });
}

class InvoiceEntity {
  String get decodedCurrencySymbol =>
      EscapeHtmlCode().convert(currencySymbol ?? "");

  String get displayNetTotal => "$decodedCurrencySymbol${nettotal ?? ""}";

  String? id;
  String? currencySymbol;
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
  String? publicKey;
  String? status;
  bool? isViewed;
  String? dateViewed;
  String? invoiceId;
  String? invoiceNo;
  bool? isAttachments;
  DateTime? dateCreated;
  //DateTime? dateModified;
  String? dueTerms;
  String? dueDate;
  String? overdueDays;
  String? overdueText;
  String? paymentReminders;
  String? paid;
  String? formatedPaid;
  String? balance;
  String? formatedBalance;
  String? heading;
  String? parentId;
  dynamic frequency;
  dynamic frequencyName;
  String? howmany;
  String? deliveryOptions;
  String? timezoneId;
  String? lastReminders;
  String? nextReminders;
  String? remindersCount;
  String? lastRecurring;
  String? nextRecurring;
  String? recurringCount;
  List<EmailtoMystaffEntity>? emailtoClientstaff;
  List<EmailtoMystaffEntity>? emailtoMystaff;
  List<InvoiceItemEntity>? items;
  List<InvoiceTaxEntity>? taxes;
  InvoiceEntity({
    this.currencySymbol,
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
    //this.dateModified,
    this.dueTerms,
    this.dueDate,
    this.overdueDays,
    this.overdueText,
    this.paymentReminders,
    this.paid,
    this.formatedPaid,
    this.balance,
    this.formatedBalance,
    this.heading,
    this.parentId,
    this.frequency,
    this.frequencyName,
    this.howmany,
    this.deliveryOptions,
    this.timezoneId,
    this.lastReminders,
    this.nextReminders,
    this.remindersCount,
    this.lastRecurring,
    this.nextRecurring,
    this.recurringCount,
    this.emailtoMystaff,
    this.items,
    this.taxes,
    this.emailtoClientstaff,
  });
  static InvoiceEntity get mock {
    return InvoiceEntity(
      id: "TEST",
      no: "123123",
      clientName: "Test Name",
      status: "recurring",
      dateYmd: DateTime.now(),
      frequency: "12",
      howmany: "12",
      overdueDays: "12",
      subtotal: "123",
      nettotal: "1233",
    );
  }

  String get dueDaysDisplayText {
    final days = overdueDays ?? "";
    if (days.isEmpty) {
      return "";
    }
    return "Due $days days ago";
  }

  Color get invoiceStatusColor {
    final status = this.status ?? "";
    if (status.toLowerCase() == "draft") {
      return AppPallete.draftColor128;
    } else if (status.toLowerCase() == "paid" ||
        status.toLowerCase() == "invoiced") {
      return AppPallete.greenColor;
    } else if (status.toLowerCase() == "overdue" ||
        status.toLowerCase() == "expired") {
      return AppPallete.expireBannerColor;
    } else if (status.toLowerCase() == "sent" ||
        status.toLowerCase() == "partial") {
      return AppPallete.orangeBannerColor;
    } else if (status.toLowerCase() == "recurring") {
      return AppPallete.purpleColor;
    }
    return AppPallete.k666666;
  }

  Color get statusColor {
    return invoiceStatusColor;
    // final status = this.status ?? "";
    // if (status.toLowerCase() == "draft") {
    //   return AppPallete.draftColor128;
    // } else if (status.toLowerCase() == "paid" ||
    //     status.toLowerCase() == "invoiced") {
    //   return AppPallete.greenColor;
    // } else if (status.toLowerCase() == "overdue" ||
    //     status.toLowerCase() == "expired") {
    //   return AppPallete.expireBannerColor;
    // } else if (status.toLowerCase() == "sent") {
    //   return AppPallete.orangeBannerColor;
    // }
    // return AppPallete.k666666;
  }
}

/*class InvoiceEntity {
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
  String? summary;
  String? currency;
  int? exchangeRate;
  String? dueTerms;
  String? dueDate;
  String? overdueDays;
  String? overdueText;
  String? paymentReminders;
  String? subtotal;
  String? discountType;
  String? discountValue;
  String? discount;
  String? taxtotal;
  String? shipping;
  String? nettotal;
  String? formatedTotal;
  String? paid;
  String? formatedPaid;
  String? balance;
  String? formatedBalance;
  String? notes;
  String? terms;
  String? heading;
  String? parentId;
  dynamic frequency;
  dynamic frequencyName;
  String? howmany;
  String? deliveryOptions;
  String? timezoneId;
  String? publicKey;
  String? status;
  bool? isViewed;
  String? dateViewed;
  String? lastReminders;
  String? nextReminders;
  String? remindersCount;
  String? lastRecurring;
  String? nextRecurring;
  String? recurringCount;
  bool? isAttachments;
  DateTime? dateCreated;
  DateTime? dateModified;
  List<EmailtoMystaffEntity>? emailtoMystaff;
  List<InvoiceItemEntity>? items;
  List<InvoiceTaxEntity>? taxes;

  InvoiceEntity({
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
    this.summary,
    this.currency,
    this.exchangeRate,
    this.dueTerms,
    this.dueDate,
    this.overdueDays,
    this.overdueText,
    this.paymentReminders,
    this.subtotal,
    this.discountType,
    this.discountValue,
    this.discount,
    this.taxtotal,
    this.shipping,
    this.nettotal,
    this.formatedTotal,
    this.paid,
    this.formatedPaid,
    this.balance,
    this.formatedBalance,
    this.notes,
    this.terms,
    this.heading,
    this.parentId,
    this.frequency,
    this.frequencyName,
    this.howmany,
    this.deliveryOptions,
    this.timezoneId,
    this.publicKey,
    this.status,
    this.isViewed,
    this.dateViewed,
    this.lastReminders,
    this.nextReminders,
    this.remindersCount,
    this.lastRecurring,
    this.nextRecurring,
    this.recurringCount,
    this.isAttachments,
    this.dateCreated,
    this.dateModified,
    this.emailtoMystaff,
    this.items,
    this.taxes,
  });
}*/

class InvoiceTaxEntity {
  String? id;
  String? name;
  dynamic rate;
  dynamic total;
  dynamic amount;

  InvoiceTaxEntity({
    this.id,
    this.name,
    this.rate,
    this.total,
    this.amount,
  });
}

class InvoiceItemEntity {
  Map<String, dynamic> toJson() => {
        "item": itemId ?? "",
        "desc": description ?? "",
        "date": date?.getDateString() ?? "",
        "time": "24:45:45",
        "custom": "",
        "qty": qty.toString(),
        "rate": rate ?? "",
        "amount": amount ?? "",
        "disc": discountValue ?? "",
        "disctype": discountType ?? "",
        "discApplied": "",
        "unit": unit ?? "",
        "taxes": taxes == null
            ? []
            : List<dynamic>.from(taxes!.map((x) => x.toJson())),
      };

  /*
  [{"item":"20636",
  "desc":"Backend application development using PHP, AJAX, MySQL",
  "date":"2023-03-03","time":"24:45:45","custom":"",
  "qty":1,"rate":55,"amount":55,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"45","name":"GST","rate":4}]},{"item":"20638","desc":"PHP, AJAX, MySQL","date":"2023-04-03","time":"24:45:45","custom":"Custome fields","qty":12,"rate":56.3,"amount":56.3,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"7","name":"GST","rate":4}]}]
  */
  String? type;
  String? itemId;
  String? itemName;
  String? description;
  DateTime? date;
  String? time;
  String? custom;
  int? qty;
  String? unit;
  String? rate;
  String? discountType;
  String? discountValue;
  String? amount;
  bool? isTaxable;
  List<TaxEntity>? taxes;

  InvoiceItemEntity({
    this.type,
    this.itemId,
    this.itemName,
    this.description,
    this.date,
    this.time,
    this.custom,
    this.qty,
    this.unit,
    this.rate,
    this.discountType,
    this.discountValue,
    this.amount,
    this.isTaxable,
    this.taxes,
  });
}

// class ItemTaxEntity {
//   String? id;
//   String? name;
//   int? rate;

//   ItemTaxEntity({
//     this.id,
//     this.name,
//     this.rate,
//   });
// }

class InvoiceListStatusCountEntity {
  String? allcount;
  String? draft;
  String? sent;
  String? partial;
  String? paid;
  String? overdue;
  String? unpaid;
  String? recurring;
  String? billed;
  String? statusCountVoid;

  InvoiceListStatusCountEntity({
    this.allcount,
    this.draft,
    this.sent,
    this.partial,
    this.paid,
    this.overdue,
    this.unpaid,
    this.recurring,
    this.billed,
    this.statusCountVoid,
  });
}

class InvoieListStatusCountsEntity {
  String? total;
  String? draft;
  String? unpaid;
  String? recurring;

  InvoieListStatusCountsEntity({
    this.total,
    this.draft,
    this.unpaid,
    this.recurring,
  });
}
