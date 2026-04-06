import 'dart:convert';

import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/proforma/domain/entities/proforma_list_entity.dart';

ProformaListMainResModel proformaListMainResModelFromJson(String str) =>
    ProformaListMainResModel.fromJson(json.decode(str));

class ProformaListMainResModel extends ProformaListMainResEntity {
  ProformaListMainResModel({
    int? success,
    ProformaListDataModel? data,
  }) : super(success: success, data: data);

  factory ProformaListMainResModel.fromJson(Map<String, dynamic> json) {
    return ProformaListMainResModel(
      success: json['success'],
      data: json['data'] == null
          ? null
          : ProformaListDataModel.fromJson(json['data']),
    );
  }
}

class ProformaListDataModel extends ProformaListDataEntity {
  ProformaListDataModel({
    bool? success,
    List<ProformaStatusCountModel>? statusCount,
    List<ProformaGrandtotalModel>? grandtotal,
    Paging? paging,
    List<ProformaModel>? proformas,
    String? message,
  }) : super(
          success: success,
          statusCount: statusCount,
          grandtotal: grandtotal,
          paging: paging,
          proformas: proformas,
          message: message,
        );

  factory ProformaListDataModel.fromJson(Map<String, dynamic> json) {
    return ProformaListDataModel(
      success: json['success'],
      statusCount: json['status_count'] == null
          ? []
          : List<ProformaStatusCountModel>.from(
              json['status_count']
                  .map((x) => ProformaStatusCountModel.fromJson(x)),
            ),
      grandtotal: json['grandtotal'] == null
          ? []
          : List<ProformaGrandtotalModel>.from(
              json['grandtotal']
                  .map((x) => ProformaGrandtotalModel.fromJson(x)),
            ),
      paging: json['paging'] == null
          ? null
          : Paging(
              from: json['paging']['from'],
              to: json['paging']['to'],
              totalrecords: json['paging']['totalrecords'],
              totalpages: json['paging']['totalpages'],
              currentpage: json['paging']['currentpage'],
              offset: json['paging']['offset'],
              length: json['paging']['length'],
              remainingrecords: json['paging']['remainingrecords'],
            ),
      proformas: json['proformas'] == null
          ? []
          : List<ProformaModel>.from(
              json['proformas'].map((x) => ProformaModel.fromJson(x)),
            ),
      message: json['message'],
    );
  }
}

class ProformaStatusCountModel extends ProformaStatusCountEntity {
  ProformaStatusCountModel({
    String? allcount,
    String? draft,
    String? sent,
    String? approved,
    String? declined,
  }) : super(
          allcount: allcount,
          draft: draft,
          sent: sent,
          approved: approved,
          declined: declined,
        );

  factory ProformaStatusCountModel.fromJson(Map<String, dynamic> json) {
    return ProformaStatusCountModel(
      allcount: json['allcount'],
      draft: json['draft'],
      sent: json['sent'],
      approved: json['approved'],
      declined: json['declined'],
    );
  }
}

class ProformaGrandtotalModel extends ProformaGrandtotalEntity {
  ProformaGrandtotalModel({
    String? currency,
    String? total,
    String? baltotal,
    String? formatedAmt,
    String? formatedAmtbal,
  }) : super(
          currency: currency,
          total: total,
          baltotal: baltotal,
          formatedAmt: formatedAmt,
          formatedAmtbal: formatedAmtbal,
        );

  factory ProformaGrandtotalModel.fromJson(Map<String, dynamic> json) {
    return ProformaGrandtotalModel(
      currency: json['currency'],
      total: json['total'],
      baltotal: json['baltotal'],
      formatedAmt: json['formated_amt'],
      formatedAmtbal: json['formated_amtbal'],
    );
  }
}

class ProformaModel extends ProformaEntity {
  ProformaModel({
    super.id,
    super.date,
    super.dateYmd,
    super.clientId,
    super.clientName,
    super.clientAddress,
    super.projectId,
    super.projectName,
    super.no,
    super.pono,
    super.expiryDate,
    super.expirydateYmd,
    super.summary,
    super.currency,
    super.currencySymbol,
    super.exchangeRate,
    super.subtotal,
    super.discountType,
    super.discountValue,
    super.discount,
    super.taxtotal,
    super.shipping,
    super.nettotal,
    super.formatedTotal,
    super.notes,
    super.terms,
    super.heading,
    super.status,
    super.dueTerms,
    super.dueDate,
    super.overdueDays,
    super.overdueText,
    super.paymentReminders,
    super.paid,
    super.formatedPaid,
    super.balance,
    super.formatedBalance,
  });

  factory ProformaModel.fromJson(Map<String, dynamic> json) {
    return ProformaModel(
      id: json['id'],
      date: json['date'],
      dateYmd:
          json['date_ymd'] == null ? null : DateTime.parse(json['date_ymd']),
      clientId: json['client_id'],
      clientName: json['client_name'],
      clientAddress: json['client_address'],
      projectId: json['project_id'],
      projectName: json['project_name'],
      no: json['no'],
      pono: json['pono'],
      expiryDate: json['expiry_date'],
      expirydateYmd: json['expirydate_ymd'],
      summary: json['summary'],
      currency: json['currency'],
      currencySymbol: json['currency_symbol'],
      exchangeRate: json['exchange_rate'],
      subtotal: json['subtotal'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      discount: json['discount'],
      taxtotal: json['taxtotal'],
      shipping: json['shipping'],
      nettotal: json['nettotal'],
      formatedTotal: json['formated_total'],
      notes: json['notes'],
      terms: json['terms'],
      heading: json['heading'],
      status: json['status'],
      dueTerms: json['due_terms'],
      dueDate: json['due_date'],
      overdueDays: json['overdue_days'],
      overdueText: json['overdue_text'],
      paymentReminders: json['payment_reminders'],
      paid: json['paid'],
      formatedPaid: json['formated_paid'],
      balance: json['balance'],
      formatedBalance: json['formated_balance'],
    );
  }
}
