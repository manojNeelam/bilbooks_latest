import 'package:billbooks_app/core/error/failures.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/account_receivables_usecase.dart';
import 'package:billbooks_app/features/dashboard/domain/usecase/auth_info_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/account_receivables_entity.dart';
import '../entity/overdue_invoice_entity.dart';
import '../entity/sales_expenses_entity.dart';
import '../entity/total_incomes_entity.dart';
import '../entity/total_receivables_entity.dart';
import '../usecase/overdue_invoice_usecase.dart';
import '../usecase/sales_expenses_usecase.dart';
import '../usecase/total_incomes_usecase.dart';
import '../usecase/total_receivables_usecase.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, AccountsReceivablesMainResEntity>>
      getAccountReceivables(AccountReceivablesUsecaseReqParams params);
  Future<Either<Failure, OverdueInvoiceMainResEntity>> getOverdueInvoices(
      OverdueInvoiceUsecaseReqParams params);
  Future<Either<Failure, SalesExpensesMainResEntity>> getSalesExpenses(
      SalesExpensesUsecaseReqParams params);
  Future<Either<Failure, TotalIncomesMainResEntity>> getTotalIncomes(
      TotalIncomesUsecaseReqParams params);
  Future<Either<Failure, TotalReceivablesMainResEntity>> getTotalReceivables(
      TotalReceivablesUsecaseReqParams params);

  Future<Either<Failure, AuthInfoMainResEntity>> getUserInfo(
      AuthInfoReqParams params);
}
