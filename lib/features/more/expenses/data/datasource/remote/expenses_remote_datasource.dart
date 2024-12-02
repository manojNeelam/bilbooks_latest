import 'package:billbooks_app/core/api/api_client.dart';
import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/features/more/expenses/data/models/add_expenses_model.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/delete_expense_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/expenses_list_usecase.dart';
import 'package:billbooks_app/features/more/expenses/domain/usecase/new_expenses_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/api/api_endpoint_urls.dart';
import '../../models/delete_expense_model.dart';
import '../../models/expenses_list_model.dart';

abstract interface class ExpensesRemoteDatasource {
  Future<ExpensesListMainResModel> getExpenses(
      ExpensesListRequestParams params);
  Future<AddExpensesMainResModel> addExpenses(NewExpensesParams params);
  Future<DeleteExpensesMainResModel> deleteExpense(
      DeleteExpenseReqParams params);
}

class ExpensesRemoteDatasourceImpl implements ExpensesRemoteDatasource {
  final APIClient apiClient;
  ExpensesRemoteDatasourceImpl({required this.apiClient});
  @override
  Future<ExpensesListMainResModel> getExpenses(
      ExpensesListRequestParams params) async {
    try {
      Map<String, String> queryParameters = {
        "status": params.status,
        "sort_column": params.sortBy,
        "sort_order": params.orderBy,
        "q": params.query,
        "page": params.page,
      };

      if (params.startDate != null) {
        queryParameters.addAll({"start_date": params.startDate ?? ""});
      }

      if (params.endDate != null) {
        queryParameters.addAll({"end_date": params.endDate ?? ""});
      }

      debugPrint(queryParameters.toString());
      final response = await apiClient.getRequest(ApiEndPoints.expenses,
          queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final resModel = expensesListMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<AddExpensesMainResModel> addExpenses(NewExpensesParams params) async {
    try {
      Map<String, String> map = {
        "date": params.date,
        "refno": params.refNo,
        "category": params.category,
        "vendor": params.vendor,
        "amount": params.amount,
        "currency": params.currency,
        "notes": params.notes,
        "client": params.cient,
        "is_billable": params.isBillable,
        "project": params.project,
        "receipt": params.receipt,
        "recurring": params.recurring,
        "howmany": params.howMany,
        "repeat": params.repeat
      };

      if (params.id.isNotEmpty) {
        map.addAll({"id": params.id});
      }

      debugPrint(map.toString());

      final body = FormData.fromMap(map);
      final response = await apiClient.postRequest(
          path: ApiEndPoints.addExpenses, body: body);
      if (response.statusCode == 200) {
        final resModel = addExpensesMainResModelFromJson(response.data);
        if (resModel.data?.success != true) {
          throw ApiException(
              message:
                  resModel.data?.message ?? "Request failed please try again!");
        }
        return resModel;
      } else {
        throw ApiException(
            message: "Invalid status code: ${response.statusCode}");
      }
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<DeleteExpensesMainResModel> deleteExpense(
      DeleteExpenseReqParams params) async {
    try {
      Map<String, String> reqPrams = {
        "id": params.id,
      };
      final response = await apiClient.deleteRequest(
          path: ApiEndPoints.deleteExpenses, queryParameters: reqPrams);
      if (response.statusCode == 200) {
        final resModel = deleteExpensesMainResModelFromJson(response.data);
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
}
