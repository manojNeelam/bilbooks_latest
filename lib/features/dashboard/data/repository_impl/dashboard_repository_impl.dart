import 'package:billbooks_app/core/api/api_exception.dart';
import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/account_receivables_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/overdue_invoice_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/sales_expenses_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/total_incomes_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/total_receivables_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/account_receivables_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/auth_info_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/overdue_invoice_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/sales_expenses_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/total_incomes_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/total_receivables_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../remote/datasource/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource dashboardRemoteDatasource;
  DashboardRepositoryImpl({required this.dashboardRemoteDatasource});

  @override
  Future<Either<Failure, AccountsReceivablesMainResEntity>>
      getAccountReceivables(AccountReceivablesUsecaseReqParams params) async {
    try {
      final res = await dashboardRemoteDatasource.getAccountReceivables(params);
      debugPrint("Dashboard Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Dashboard Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Dashboard Repository: default error");
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OverdueInvoiceMainResEntity>> getOverdueInvoices(
      OverdueInvoiceUsecaseReqParams params) async {
    try {
      final res = await dashboardRemoteDatasource.getOverdueInvoices(params);
      debugPrint("Dashboard Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Dashboard Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Dashboard Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SalesExpensesMainResEntity>> getSalesExpenses(
      SalesExpensesUsecaseReqParams params) async {
    try {
      final res = await dashboardRemoteDatasource.getSalesExpenses(params);
      debugPrint("Dashboard Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Dashboard Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Dashboard Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TotalIncomesMainResEntity>> getTotalIncomes(
      TotalIncomesUsecaseReqParams params) async {
    try {
      final res = await dashboardRemoteDatasource.getTotalIncomes(params);
      debugPrint("Dashboard Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Dashboard Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Dashboard Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TotalReceivablesMainResEntity>> getTotalReceivables(
      TotalReceivablesUsecaseReqParams params) async {
    try {
      final res = await dashboardRemoteDatasource.getTotalReceivables(params);
      debugPrint("Dashboard Repository: success");
      return right(res);
    } on ApiException catch (e) {
      debugPrint("Dashboard Repository: api exception error");
      return left(Failure(e.message));
    } catch (e) {
      debugPrint("Dashboard Repository: default error");

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthInfoMainResEntity>> getUserInfo(
      AuthInfoReqParams params) async {
    try {
      final res = await dashboardRemoteDatasource.getAuthInfo(params);
      return right(res);
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
