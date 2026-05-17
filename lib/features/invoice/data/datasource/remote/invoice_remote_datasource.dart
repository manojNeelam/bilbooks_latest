import 'dart:convert';

import 'package:billbooks_app/core/api/api_constants.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/features/invoice/data/models/add_invoice_model.dart';
import 'package:billbooks_app/features/invoice/data/models/client_staff_model.dart';
import 'package:billbooks_app/features/invoice/data/models/get_document_model.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_details_model.dart';
import 'package:billbooks_app/features/invoice/data/models/invoice_marksend_model.dart';
import 'package:billbooks_app/features/invoice/data/models/send_document_model.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/client_staff_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/delete_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_delete_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_list_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_markassend_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_void_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_details_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_list_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:billbooks_app/features/invoice/presentation/send_invoice_estimate_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_endpoint_urls.dart';
import '../../../../../core/api/api_exception.dart';
import '../../../domain/entities/client_staff_entity.dart';
import '../../../domain/entities/invoice_details_entity.dart';
import '../../../domain/usecase/invoice_unvoid_usecase.dart';
import '../../../domain/usecase/send_document_usecase.dart';
import '../../models/add_payment_model.dart';
import '../../models/delete_payment_model.dart';
import '../../models/invoice_delete_model.dart';
import '../../models/invoice_list_model.dart';
import '../../models/invoice_unvoid_model.dart';
import '../../models/invoice_void_model.dart';
import '../../models/payment_detail_model.dart';
import '../../models/payment_list_model.dart';

abstract interface class InvoiceRemoteDatasource {
  Future<InvoiceDetailsResponseModel> getInvoiceDetails(
      InvoiceDetailRequest params);
  Future<InvoiceListMainResModel> getInvoices(InvoiceListReqParams params);
  Future<AddInvoiceMainResModel> addInvoices(AddInvoiceReqParms params);
  Future<PaymentListMainResModel> getPaymentList(PaymentListReqParams params);
  Future<PaymentDetailMainResModel> getPaymentDetails(
      PaymentDetailsReqParms params);
  Future<InvoiceVoidMainResModel> invoiceVoid(InvoiceVoidReqParms params);
  Future<InvoiceUnVoidMainResModel> invoiceUnVoid(InvoiceUnVoidReqParms params);
  Future<InvoiceMarksendMainResModel> invoiceMarkSend(
      InvoiceMarkassendReqParms params);
  Future<InvoiceDeleteMainResModel> deleteInvoice(InvoiceDeleteReqParms params);
  Future<ClientStaffMainResEntity> getClientStaff(
      ClientStaffUsecaseReqParams params);

  Future<GetDocumentMainResModel> getDocuments(
      GetDocumentUsecaseReqParams params);

  Future<SendDocumentMainResModel> sendDocuments(
      SendDocumentUsecaseReqParams params);

  Future<DeletePaymentMethodMainResModel> deletePayment(
      DeletePaymentUsecaseReqParams params);

  Future<AddPaymentMethodMainResModel> addPayment(
      AddPaymentUsecaseReqParms params);
}

class InvoiceRemoteDatasourceImpl implements InvoiceRemoteDatasource {
  final APIClient apiClient;
  InvoiceRemoteDatasourceImpl({required this.apiClient});

  bool _isInvoiceType(EnumNewInvoiceEstimateType type) {
    return type == EnumNewInvoiceEstimateType.invoice ||
        type == EnumNewInvoiceEstimateType.editInvoice ||
        type == EnumNewInvoiceEstimateType.duplicateInvoice ||
        type == EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
        type == EnumNewInvoiceEstimateType.convertProformaToInvoice;
  }

  String _formatPayloadDate(DateTime? date) {
    if (date == null) {
      return "";
    }
    return date.getDateString(format: 'yyyy-MM-dd');
  }

  dynamic _resolveRequestId(AddInvoiceReqParms params) {
    final id = (params.id ?? '').trim();
    final shouldSendCurrentId =
        params.type == EnumNewInvoiceEstimateType.editInvoice ||
            params.type == EnumNewInvoiceEstimateType.editEstimate;
    if (shouldSendCurrentId && id.isNotEmpty) {
      return int.tryParse(id) ?? id;
    }
    return 0;
  }

  dynamic _resolveEstimateReference(AddInvoiceReqParms params) {
    if (params.type != EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
      return "";
    }
    final id = (params.id ?? '').trim();
    return int.tryParse(id) ?? id;
  }

  String _resolveHowMany(InvoiceRequestModel req) {
    if (req.isRecurring != true) {
      return '-1';
    }
    if (req.isInfinite == true) {
      return '-1';
    }
    final remaining = (req.remaining ?? '').trim();
    return remaining.isNotEmpty ? remaining : '-1';
  }

  String _resolveRepeat(InvoiceRequestModel req) {
    if (req.isRecurring != true) {
      return '';
    }
    return req.selectedRepeatEvery?.value ?? '';
  }

  List<Map<String, dynamic>> _serializeStaff(
      List<EmailtoMystaffEntity> staffList) {
    return staffList.map((returnedStaff) {
      return InvoiceStaffModel(
        id: returnedStaff.id ?? '',
        name: returnedStaff.name ?? '',
      ).toJson();
    }).toList();
  }

  @override
  Future<InvoiceDetailsResponseModel> getInvoiceDetails(
      InvoiceDetailRequest params) async {
    bool isEstimate() {
      if (params.type == EnumNewInvoiceEstimateType.estimate ||
          params.type == EnumNewInvoiceEstimateType.editEstimate ||
          params.type == EnumNewInvoiceEstimateType.duplicateEstimate) {
        return true;
      }
      return false;
    }

    try {
      Map<String, String> queryParameters = {};
      if (params.id != null) {
        queryParameters.addAll({"id": params.id ?? ""});
      }
      final path = isEstimate()
          ? ApiEndPoints.estimateDetails
          : ApiEndPoints.invoiceDetails;
      final response = await apiClient.getRequest(
        path,
        queryParameters: queryParameters,
      );
      debugPrint("InvoiceRemoteDatasourceImpl ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = InvoiceDetailsResponseModel.fromJson(response.data);
        //debugPrint("resModel: ${resModel.data?.taxes?.first.name.toString()}");
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());

      debugPrint("InvoiceRemoteDatasourceImpl error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<InvoiceListMainResModel> getInvoices(
      InvoiceListReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {
        "status": params.status,
        "page": params.page,
        "q": params.query,
        "date_start": params.startDate ?? "",
        "date_end": params.endDate ?? "",
        "sort_column": params.columnName,
        "sort_order": params.sortOrder,
      };
      debugPrint(queryParameters.toString());

      final response = await apiClient.getRequest(ApiEndPoints.invoices,
          queryParameters: queryParameters);
      debugPrint("InvoiceListMainResModelImpl ");
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        final resModel = InvoiceListMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());

      debugPrint("InvoiceRemoteDatasourceImpl error");
      throw ApiException(message: e.toString());
    }
  }

/*

client:23537
no:EST021
date:04/05/2024
project:
pono:
expiry_date:11/08/2024
summary:
currency:
exchange_rate:
subtotal:55
discount_type:0
discount_value:0
discount:0
taxtotal:5.5
shipping:0
nettotal:60.5
notes:Note Here
terms:asdf
items:[{"item":"20636","desc":"Backend application development using PHP, AJAX, MySQL","date":"2023-03-03","time":"24:45:45","custom":"","qty":1,"rate":55,"amount":55,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"45","name":"GST","rate":4}]},{"item":"20638","desc":"PHP, AJAX, MySQL","date":"2023-04-03","time":"24:45:45","custom":"Custome fields","qty":12,"rate":56.3,"amount":56.3,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"7","name":"GST","rate":4}]}]
emailto_mystaff:[{"id":"2468","email":"abc@exaple.com"},{"id":"2469","email":"pqr"}]
emailto_clientstaff:[{"id":"23214","email":"abc@exaple.com"},{"id":"23216","email":"pqr"}]

let payment_reminders: String
    let client: String
    let no: String
    let date: String
    let project: String
    let pono: String
    let expiry_date: String
    let summary: String
    let currency: String
    let exchange_rate: String
    let subtotal: String
    let discount_type: String
    let discount_value: String
    let discount: String
    let taxtotal: String
    let shipping: String
    let nettotal: String
    let notes: String
    let terms: String
    let dueterms: String
    let heading: String
    let howmany: String
    let delivery_options: String
    let timezone: String
    
    let items: String
    let emailto_mystaff: String
    let emailto_clientstaff: String
*/

  @override
  Future<AddInvoiceMainResModel> addInvoices(AddInvoiceReqParms params) async {
    try {
      Map<String, dynamic> map = {};

      if (params.invoiceRequestModel != null) {
        final req = params.invoiceRequestModel!;
        final isProformaPayload = params.isProforma;

        map.addAll({
          "id": _resolveRequestId(params),
          "estimate": _resolveEstimateReference(params),
          if (!isProformaPayload)
            "recurring": req.isRecurring == true ? "true" : "false",

          // keep these as plain scalar form fields
          "client": params.selectedClient?.clientId ?? "",
          "project": params.selectedProject?.id ?? "",

          "date": _formatPayloadDate(req.date),
          "expiry_date": _formatPayloadDate(req.expiryDate ?? req.date),
          "dueterms": isProformaPayload
              ? (params.dueTerms ?? "0")
              : (req.selectedPaymentTerms?.value ?? "0"),
          "payment_reminders": req.selectedPaymentReminder?.value ?? "0",
          "heading": req.heading ?? "",
          if (!isProformaPayload) "repeat": _resolveRepeat(req),
          if (!isProformaPayload) "howmany": _resolveHowMany(req),
          "no": req.no ?? "",
          "pono": req.poNumber ?? "",
          "summary": req.title ?? "",
          "exchange_rate": params.exchangeRate ?? "1",
          if (!isProformaPayload)
            "timezone": req.selectedTimezones?.timezoneId ?? "",
          "delivery_options": req.selectedDeliveryOption?.value ?? "0",
          "subtotal": params.subTotal ?? "",
          "discount_type": params.discountType ?? "0",
          "discount": params.discount ?? "0",
          "taxtotal": params.taxTotal ?? "",
          "shipping": params.shipping ?? "",
          "nettotal": params.netTotal ?? "",
          "notes": params.notes ?? "",
          "terms": params.terms ?? "",
          "attachments": "",
          "currency": params.currency ?? "",

          // JSON encode complex payloads for multipart form-data
          "items": jsonEncode(
            params.selectedLineItems.map((x) => x.toJson()).toList(),
          ),

          "emailto_clientstaff": jsonEncode(
            _serializeStaff(params.selectedClientStaff),
          ),

          "emailto_mystaff": jsonEncode(
            _serializeStaff(params.selectedMyStaffList),
          ),
          if (!isProformaPayload)
            "creditnotes": jsonEncode(params.creditNotes ?? []),
        });

        if (params.type ==
            EnumNewInvoiceEstimateType.convertProformaToInvoice) {
          final id = (params.id ?? '').trim();
          map.addAll({
            "proforma": int.tryParse(id) ?? id,
          });
        }
      } else {
        debugPrint("EMPTY REQ");
      }

      debugPrint("Map: $map");

      final path = params.isProforma
          ? ApiEndPoints.addProforma
          : _isInvoiceType(params.type)
              ? ApiEndPoints.addinvoice
              : ApiEndPoints.addEstimate;

      debugPrint("Path: $path");

      final body = FormData.fromMap(map);

      final response = await apiClient.postRequest(
        path: path,
        body: body,
      );

      debugPrint("Response came");

      if (response.statusCode == 200) {
        final resModel = AddInvoiceMainResModel.fromJson(response.data);

        if (resModel.data?.success != true) {
          throw ApiException(
            message:
                resModel.data?.message ?? "Request failed please try again!",
          );
        }

        return resModel;
      } else {
        throw ApiException(
          message: 'Invalid status code : ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PaymentListMainResModel> getPaymentList(
      PaymentListReqParams params) async {
    try {
      Map<String, String> map = {"id": params.id};
      final response = await apiClient.getRequest(ApiEndPoints.paymentList,
          queryParameters: map);
      debugPrint("PaymentListMainResModel ");
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        final resModel = PaymentListMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());

      debugPrint("PaymentListMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PaymentDetailMainResModel> getPaymentDetails(
      PaymentDetailsReqParms params) async {
    try {
      Map<String, String> queryParameters = {"id": params.id};
      final response = await apiClient.getRequest(ApiEndPoints.paymentDetails,
          queryParameters: queryParameters);
      debugPrint("PaymentDetailMainResModel ");
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        final resModel = PaymentDetailMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());

      debugPrint("PaymentDetailMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<InvoiceVoidMainResModel> invoiceVoid(
      InvoiceVoidReqParms params) async {
    try {
      Map<String, String> map = {"id": params.id};
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.invoiceVoid, body: body);
      if (response.statusCode == 200) {
        final resModel = InvoiceVoidMainResModel.fromJson(response.data);
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<InvoiceUnVoidMainResModel> invoiceUnVoid(
      InvoiceUnVoidReqParms params) async {
    try {
      Map<String, String> map = {"id": params.id};
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.invoiceUnVoid, body: body);
      if (response.statusCode == 200) {
        final resModel = InvoiceUnVoidMainResModel.fromJson(response.data);
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<InvoiceMarksendMainResModel> invoiceMarkSend(
      InvoiceMarkassendReqParms params) async {
    try {
      Map<String, String> map = {"id": params.id};
      FormData body = FormData.fromMap(map);
      final path = switch (params.type) {
        EnumDocumentType.invoice => ApiEndPoints.invoiceMarkAsSend,
        EnumDocumentType.estimate => ApiEndPoints.estimateMarkAsSent,
        EnumDocumentType.proforma => ApiEndPoints.proformaMarkAsSent,
      };
      final response = await apiClient.postRequest(path: path, body: body);
      if (response.statusCode == 200) {
        final resModel = InvoiceMarksendMainResModel.fromJson(response.data);
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<InvoiceDeleteMainResModel> deleteInvoice(
      InvoiceDeleteReqParms params) async {
    try {
      Map<String, String> reqPrams = {
        "id": params.id,
      };
      final path = switch (params.type) {
        EnumDocumentType.invoice => ApiEndPoints.invoiceDelete,
        EnumDocumentType.estimate => ApiEndPoints.estimateDelete,
        EnumDocumentType.proforma => ApiEndPoints.proformaDelete,
      };
      final response =
          await apiClient.deleteRequest(path: path, queryParameters: reqPrams);
      if (response.statusCode == 200) {
        final resModel = InvoiceDeleteMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<ClientStaffMainResEntity> getClientStaff(
      ClientStaffUsecaseReqParams params) async {
    try {
      Map<String, String> reqPrams = {
        "id": params.id,
      };
      final response = await apiClient.getRequest(ApiEndPoints.clientStaff,
          queryParameters: reqPrams);
      if (response.statusCode == 200) {
        final resModel = ClientStaffMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<GetDocumentMainResModel> getDocuments(
      GetDocumentUsecaseReqParams params) async {
    try {
      Map<String, String> reqPrams = {
        "id": params.id,
        "document_type": params.type.name
      };
      final response = await apiClient.getRequest(params.pageType.path,
          queryParameters: reqPrams);
      if (response.statusCode == 200) {
        final resModel = GetDocumentMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<DeletePaymentMethodMainResModel> deletePayment(
      DeletePaymentUsecaseReqParams params) async {
    try {
      Map<String, String> reqPrams = {
        "id": params.id,
      };
      final response = await apiClient.deleteRequest(
          path: ApiEndPoints.deletePayment, queryParameters: reqPrams);
      if (response.statusCode == 200) {
        final resModel =
            DeletePaymentMethodMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid Status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<AddPaymentMethodMainResModel> addPayment(
      AddPaymentUsecaseReqParms params) async {
    try {
      Map<String, String> map = {
        "date": params.date,
        "amount": params.amount,
        "invoice_id": params.invoiceId,
        "method": params.method.toLowerCase(),
        "refno": params.refno,
        "notes": params.notes,
        "send_thankyou": params.sendThankYou ? "true" : "false",
        "sendto": ""
      };
      if (params.id != null) {
        map.addAll({"id": params.id ?? ""});
      }
      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.addPayment, body: body);
      if (response.statusCode == 200) {
        final resModel = AddPaymentMethodMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<SendDocumentMainResModel> sendDocuments(
      SendDocumentUsecaseReqParams params) async {
    try {
      /*
      id:100
from:2
sendto[0]:89
//sendto[1]:23478
bcc[0]:2
//bcc[1]:3221
message:Dear Samuel, Thank you! We have received your payment against invoice #10502. Best regards, Webwingz Pty ltd
subject:Payment received - Thanks 
      */
      Map<String, dynamic> map = {
        "id": params.id,
        "from": params.from,
        "message": params.message,
        "subject": params.subject,
        "document_type": params.type.name,
        "attach_pdf": params.isAttachPdf ? "true" : "false",
      };
      for (final (index, item) in params.bcc.indexed) {
        map.addAll({"bcc[$index]": item.id});
      }
      for (final (index, item) in params.sendTo.indexed) {
        map.addAll({"sendto[$index]": item.id});
      }

      debugPrint("Req Map: ${map.toString()}");

      FormData body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.getDocuments, body: body);
      if (response.statusCode == 200) {
        final resModel = SendDocumentMainResModel.fromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: 'Invalid status code : ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}

class InvoiceStaffModel {
  final String id;
  final String name;
  InvoiceStaffModel({
    required this.name,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
