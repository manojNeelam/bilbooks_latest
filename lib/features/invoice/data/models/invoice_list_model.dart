// To parse this JSON data, do
//
//     final invoiceListMainResModel = invoiceListMainResModelFromJson(jsonString);

import 'dart:convert';

import 'package:billbooks_app/features/clients/data/models/client_list_model.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';

import '../../../clients/domain/entities/client_list_entity.dart';
import '../../domain/entities/invoice_details_entity.dart';

InvoiceListMainResModel invoiceListMainResModelFromJson(String str) =>
    InvoiceListMainResModel.fromJson(json.decode(str));

class InvoiceListMainResModel extends InvoiceListMainResEntity {
  InvoiceListMainResModel({int? success, InvoiceListDataModel? data})
      : super(data: data, success: success);

  factory InvoiceListMainResModel.fromJson(Map<String, dynamic> json) =>
      InvoiceListMainResModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : InvoiceListDataModel.fromJson(json["data"]),
      );
}

class InvoiceListDataModel extends InvoiceListDataEntity {
  InvoiceListDataModel(
      {bool? success,
      List<InvoiceListStatusCountModel>? statusCount,
      List<GrandtotalModel>? grandtotal,
      PagingModel? paging,
      List<InvoiceModel>? invoices,
      InvoiceListStatusCountsModel? statusCounts,
      String? message})
      : super(
            success: success,
            statusCount: statusCount,
            grandtotal: grandtotal,
            paging: paging,
            invoices: invoices,
            statusCounts: statusCounts);

  factory InvoiceListDataModel.fromJson(Map<String, dynamic> json) =>
      InvoiceListDataModel(
        success: json["success"],
        statusCount: json["status_count"] == null
            ? []
            : List<InvoiceListStatusCountModel>.from(json["status_count"]!
                .map((x) => InvoiceListStatusCountModel.fromJson(x))),
        grandtotal: json["grandtotal"] == null
            ? []
            : List<GrandtotalModel>.from(
                json["grandtotal"]!.map((x) => GrandtotalModel.fromJson(x))),
        paging: json["paging"] == null
            ? null
            : PagingModel.fromJson(json["paging"]),
        invoices: json["invoices"] == null
            ? []
            : List<InvoiceModel>.from(
                json["invoices"]!.map((x) => InvoiceModel.fromJson(x))),
        statusCounts: json["status_counts"] == null
            ? null
            : InvoiceListStatusCountsModel.fromJson(json["status_counts"]),
        message: json["message"],
      );
}

class GrandtotalModel extends GrandtotalEntity {
  GrandtotalModel(
      {String? currency,
      String? total,
      String? baltotal,
      String? formatedAmt,
      String? formatedAmtbal})
      : super(
            currency: currency,
            total: total,
            baltotal: baltotal,
            formatedAmt: formatedAmt,
            formatedAmtbal: formatedAmtbal);

  factory GrandtotalModel.fromJson(Map<String, dynamic> json) =>
      GrandtotalModel(
        currency: json["currency"],
        total: json["total"],
        baltotal: json["baltotal"],
        formatedAmt: json["formated_amt"],
        formatedAmtbal: json["formated_amtbal"],
      );
}

class InvoiceModel extends InvoiceEntity {
  InvoiceModel({
    String? id,
    String? date,
    DateTime? dateYmd,
    String? clientId,
    String? clientName,
    String? clientAddress,
    String? projectId,
    String? projectName,
    String? no,
    String? pono,
    String? expiryDate,
    String? expirydateYmd,
    String? summary,
    String? currency,
    dynamic exchangeRate,
    String? subtotal,
    String? discountType,
    String? discountValue,
    String? discount,
    String? taxtotal,
    String? shipping,
    String? nettotal,
    String? formatedTotal,
    String? notes,
    String? terms,
    String? publicKey,
    String? status,
    bool? isViewed,
    String? dateViewed,
    String? invoiceId,
    String? invoiceNo,
    bool? isAttachments,
    DateTime? dateCreated,
    DateTime? dateModified,
    String? dueTerms,
    String? dueDate,
    String? overdueDays,
    String? overdueText,
    String? paymentReminders,
    String? paid,
    String? formatedPaid,
    String? balance,
    String? formatedBalance,
    String? heading,
    String? parentId,
    dynamic frequency,
    dynamic frequencyName,
    String? howmany,
    String? deliveryOptions,
    String? timezoneId,
    String? lastReminders,
    String? nextReminders,
    String? remindersCount,
    String? lastRecurring,
    String? nextRecurring,
    String? recurringCount,
    List<EmailtoMystaffData>? emailtoClientstaff,
    List<EmailtoMystaffData>? emailtoMystaff,
    List<InvoiceItemModel>? items,
    List<InvoiceTaxModel>? taxes,
  }) : super(
          items: items,
          emailtoMystaff: emailtoMystaff,
          //dateModified: dateModified,
          dateCreated: dateCreated,
          isAttachments: isAttachments,
          recurringCount: recurringCount,
          nextRecurring: nextRecurring,
          lastRecurring: lastRecurring,
          remindersCount: remindersCount,
          nextReminders: nextReminders,
          lastReminders: lastReminders,
          dateViewed: dateViewed,
          isViewed: isViewed,
          status: status,
          publicKey: publicKey,
          timezoneId: timezoneId,
          deliveryOptions: deliveryOptions,
          howmany: howmany,
          frequencyName: frequencyName,
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
          summary: summary,
          currency: currency,
          exchangeRate: exchangeRate,
          dueTerms: dueTerms,
          dueDate: dueDate,
          overdueDays: overdueDays,
          overdueText: overdueText,
          paymentReminders: paymentReminders,
          subtotal: subtotal,
          discountType: discountType,
          discountValue: discountValue,
          discount: discount,
          taxtotal: taxtotal,
          shipping: shipping,
          nettotal: nettotal,
          formatedTotal: formatedTotal,
          paid: paid,
          formatedPaid: formatedPaid,
          balance: balance,
          formatedBalance: formatedBalance,
          notes: notes,
          terms: terms,
          heading: heading,
          parentId: parentId,
          frequency: frequency,
          taxes: taxes,
          expiryDate: expiryDate,
          expirydateYmd: expirydateYmd,
          emailtoClientstaff: emailtoClientstaff,
        );
/*
json["persons"] == null
            ? []
            : List<PersonModel>.from(
                json["persons"]!.map((x) => PersonModel.fromJson(x)))
*/
  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        items: json["items"] == null
            ? []
            : List<InvoiceItemModel>.from(
                json["items"]!.map((x) => InvoiceItemModel.fromJson(x))),
        taxes: json["taxes"] == null
            ? []
            : List<InvoiceTaxModel>.from(
                json["taxes"]!.map((x) => InvoiceTaxModel.fromJson(x))),
        emailtoMystaff: json["emailto_mystaff"] == null
            ? []
            : List<EmailtoMystaffData>.from(json["emailto_mystaff"]!
                .map((x) => EmailtoMystaffData.fromJson(x))),
        emailtoClientstaff: json["emailto_clientstaff"] == null
            ? []
            : List<EmailtoMystaffData>.from(json["emailto_clientstaff"]!
                .map((x) => EmailtoMystaffData.fromJson(x))),
        id: json["id"],
        date: json["date"],
        dateYmd:
            json["date_ymd"] == null ? null : DateTime.parse(json["date_ymd"]),
        clientId: json["client_id"],
        clientName: json["client_name"],
        clientAddress: json["client_address"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        no: json["no"],
        expiryDate: json["expiry_date"],
        expirydateYmd: json["expirydate_ymd"],
        pono: json["pono"],
        summary: json["summary"],
        currency: json["currency"],
        //exchangeRate: json["exchange_rate"],
        dueTerms: json["due_terms"],
        dueDate: json["due_date"],
        overdueDays: json["overdue_days"],
        overdueText: json["overdue_text"],
        paymentReminders: json["payment_reminders"],
        subtotal: json["subtotal"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        discount: json["discount"],
        taxtotal: json["taxtotal"],
        shipping: json["shipping"],
        nettotal: json["nettotal"],
        formatedTotal: json["formated_total"],
        paid: json["paid"],
        formatedPaid: json["formated_paid"],
        balance: json["balance"],
        formatedBalance: json["formated_balance"],
        notes: json["notes"],
        terms: json["terms"],
        heading: json["heading"],
        parentId: json["parent_id"],
        frequency: json["frequency"],
        frequencyName: json["frequency_name"],
        howmany: json["howmany"],
        deliveryOptions: json["delivery_options"],
        timezoneId: json["timezone_id"],
        publicKey: json["public_key"],
        status: json["status"],
        isViewed: json["is_viewed"],
        dateViewed: json["date_viewed"],
        lastReminders: json["last_reminders"],
        nextReminders: json["next_reminders"],
        remindersCount: json["reminders_count"],
        lastRecurring: json["last_recurring"],
        nextRecurring: json["next_recurring"],
        recurringCount: json["recurring_count"],
        isAttachments: json["is_attachments"],
        invoiceId: json["invoice_id"],
        invoiceNo: json["invoice_no"],
        // dateCreated: json["date_created"] == null
        //     ? null
        //     : DateTime.parse(json["date_created"]),
        // dateModified: json["date_modified"] == null
        //     ? null
        //     : DateTime.parse(json["date_modified"]),
      );
}

class InvoiceListStatusCountModel extends InvoiceListStatusCountEntity {
  InvoiceListStatusCountModel({
    String? allcount,
    String? draft,
    String? sent,
    String? partial,
    String? paid,
    String? overdue,
    String? unpaid,
    String? recurring,
    String? billed,
    String? statusCountVoid,
  }) : super(
            allcount: allcount,
            draft: draft,
            sent: sent,
            partial: partial,
            paid: paid,
            overdue: overdue,
            unpaid: unpaid,
            recurring: recurring,
            billed: billed,
            statusCountVoid: statusCountVoid);

  factory InvoiceListStatusCountModel.fromJson(Map<String, dynamic> json) =>
      InvoiceListStatusCountModel(
        allcount: json["allcount"],
        draft: json["draft"],
        sent: json["sent"],
        partial: json["partial"],
        paid: json["paid"],
        overdue: json["overdue"],
        unpaid: json["unpaid"],
        recurring: json["recurring"],
        billed: json["billed"],
        statusCountVoid: json["void"],
      );
}

class InvoiceListStatusCountsModel extends InvoieListStatusCountsEntity {
  InvoiceListStatusCountsModel({
    String? total,
    String? draft,
    String? unpaid,
    String? recurring,
  }) : super(total: total, draft: draft, unpaid: unpaid, recurring: recurring);

  factory InvoiceListStatusCountsModel.fromJson(Map<String, dynamic> json) =>
      InvoiceListStatusCountsModel(
        total: json["total"],
        draft: json["draft"],
        unpaid: json["unpaid"],
        recurring: json["recurring"],
      );
}
