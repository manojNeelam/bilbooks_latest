import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/features/dashboard/data/model/authinfo_model.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/auth_info_usecase.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/api_endpoint_urls.dart';
import '../../../../../core/api/api_exception.dart';
import '../../../domain/usecase/account_receivables_usecase.dart';
import '../../../domain/usecase/overdue_invoice_usecase.dart';
import '../../../domain/usecase/sales_expenses_usecase.dart';
import '../../../domain/usecase/total_incomes_usecase.dart';
import '../../../domain/usecase/total_receivables_usecase.dart';
import '../../model/account_receivables_model.dart';
import '../../model/overdue_invoice_model.dart';
import '../../model/sales_expenses_model.dart';
import '../../model/total_incomes_model.dart';
import '../../model/total_receivables_model.dart';

abstract interface class DashboardRemoteDatasource {
  Future<AccountsReceivablesMainResModel> getAccountReceivables(
      AccountReceivablesUsecaseReqParams params);
  Future<OverdueInvoiceMainResModel> getOverdueInvoices(
      OverdueInvoiceUsecaseReqParams params);
  Future<SalesExpensesMainResModel> getSalesExpenses(
      SalesExpensesUsecaseReqParams params);
  Future<TotalIncomesMainResModel> getTotalIncomes(
      TotalIncomesUsecaseReqParams params);
  Future<TotalReceivablesMainResModel> getTotalReceivables(
      TotalReceivablesUsecaseReqParams params);

  Future<AuthInfoMainResModel> getAuthInfo(AuthInfoReqParams params);
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final APIClient apiClient;
  DashboardRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<AccountsReceivablesMainResModel> getAccountReceivables(
      AccountReceivablesUsecaseReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {};

      final response = await apiClient.getRequest(
          ApiEndPoints.accountsreceivables,
          queryParameters: queryParameters);
      debugPrint("AccountsReceivablesMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = accountsReceivablesMainResModelFromJson(response.data);
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

      debugPrint("AccountsReceivablesMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<OverdueInvoiceMainResModel> getOverdueInvoices(
      OverdueInvoiceUsecaseReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {};

      final response = await apiClient.getRequest(ApiEndPoints.overdueinvoices,
          queryParameters: queryParameters);
      debugPrint("OverdueInvoiceMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = overdueInvoiceMainResModelFromJson(response.data);
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

      debugPrint("OverdueInvoiceMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<SalesExpensesMainResModel> getSalesExpenses(
      SalesExpensesUsecaseReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {};

      if (params.startDate != null &&
          params.startDate!.isNotEmpty &&
          params.endDate != null &&
          params.endDate!.isNotEmpty) {
        queryParameters.addAll({
          "date_start": params.startDate,
          "date_end": params.endDate,
        });
      }

      final response = await apiClient.getRequest(ApiEndPoints.salesandexpenses,
          queryParameters: queryParameters);
      debugPrint("SalesExpensesMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = salesExpensesMainResModelFromJson(response.data);
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

      debugPrint("SalesExpensesMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<TotalIncomesMainResModel> getTotalIncomes(
      TotalIncomesUsecaseReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {};

      final response = await apiClient.getRequest(ApiEndPoints.totalincomes,
          queryParameters: queryParameters);
      debugPrint("TotalIncomesMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = totalIncomesMainResModelFromJson(response.data);
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

      debugPrint("TotalIncomesMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<TotalReceivablesMainResModel> getTotalReceivables(
      TotalReceivablesUsecaseReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {};

      final response = await apiClient.getRequest(ApiEndPoints.totalreceivables,
          queryParameters: queryParameters);
      debugPrint("TotalReceivablesMainResModel ");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = totalReceivablesMainResModelFromJson(response.data);
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

      debugPrint("TotalReceivablesMainResModel error");
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<AuthInfoMainResModel> getAuthInfo(AuthInfoReqParams params) async {
    try {
      Map<String, dynamic> queryParameters = {};

      final response = await apiClient.getRequest(ApiEndPoints.authInfo,
          queryParameters: queryParameters);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final resModel = authInfoMainResModelFromJson(response.data);
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

      throw ApiException(message: e.toString());
    }
  }
}
