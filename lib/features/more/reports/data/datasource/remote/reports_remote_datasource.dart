//abstract
//impl
import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/features/more/reports/data/models/outstanding_report_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../../../core/api/api_client.dart';
import '../../../../../../core/api/api_endpoint_urls.dart';
import '../../../presentation/model/invoice_report_model.dart';
import '../../../presentation/model/outstanding_report_model.dart';
import '../../models/invoice_report_model.dart';

abstract interface class ReportsRemoteDatasource {
  Future<InvoiceReportMainResModel> getInvoiceReport(
      InvoiceReportReqPrarams params);
  Future<OutstandingReportMainResModel> getOutstandingReport(
      OutstandingReportReqParams params);
}

class ReportsRemoteDatasourceImpl implements ReportsRemoteDatasource {
  final APIClient apiClient;
  ReportsRemoteDatasourceImpl(this.apiClient);
  @override
  Future<InvoiceReportMainResModel> getInvoiceReport(
      InvoiceReportReqPrarams params) async {
    try {
      // TODO: pass request
      Map<String, dynamic> queryParameters = {};
      debugPrint(queryParameters.toString());
      final response = await apiClient.getRequest(ApiEndPoints.invoiceReport,
          queryParameters: queryParameters);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = InvoiceReportMainResModel.fromJson(response.data);
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
      debugPrint("getInvoiceReport error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<OutstandingReportMainResModel> getOutstandingReport(
      OutstandingReportReqParams params) async {
    try {
      // TODO: pass request
      Map<String, dynamic> queryParameters = {};
      debugPrint(queryParameters.toString());
      final response = await apiClient.getRequest(
          ApiEndPoints.outstandingReport,
          queryParameters: queryParameters);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = OutstandingReportMainResModel.fromJson(response.data);
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
      debugPrint("getOutstandingReport error");
      throw ApiException(message: e.toString());
    }
  }
}
