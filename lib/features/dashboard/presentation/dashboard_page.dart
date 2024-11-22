import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import '../domain/entity/authinfo_entity.dart';
import 'widgets/accounts_receivables_widget.dart';
import 'widgets/overdue_invoce_widget.dart';
import 'widgets/salesexpenses_widget.dart';
import 'widgets/total_invoice_widget.dart';
import 'widgets/total_receivables_widget.dart';

class DashboardPage extends StatefulWidget {
  final AuthInfoMainDataEntity authInfoMainDataEntity;
  const DashboardPage({super.key, required this.authInfoMainDataEntity});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin {
  AuthInfoMainDataEntity? authInfoMainDataEntity;
  @override
  void initState() {
    authInfoMainDataEntity = widget.authInfoMainDataEntity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: null,
              child: Text(
                "Test",
                style: AppFonts.regularStyle(color: Colors.transparent),
              ))
        ],
        leading: IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            AutoRouter.of(context).push(const NotificationPageRoute());
          },
        ),
        title: GestureDetector(
          onTap: () {
            debugPrint("on tap user profile");
            AutoRouter.of(context).push(UserProfilePageRoute(
                authInfoMainDataEntity: authInfoMainDataEntity,
                refresh: () {
                  setState(() {});
                }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  authInfoMainDataEntity?.sessionData?.organization?.name ?? "",
                  style: AppFonts.mediumStyle(),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: AppPallete.borderColor,
              )
            ],
          ),
        ),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              SalesexpensesWidget(),
              AppConstants.sizeBoxHeight15,
              OverdueInvoceWidget(),
              AppConstants.sizeBoxHeight15,
              TotalInvoiceWidget(),
              AppConstants.sizeBoxHeight15,
              TotalReceivablesWidget(),
              AppConstants.sizeBoxHeight15,
              AccountsReceivables(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

 

/*
body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is AccountReceivablesSuccessState) {
            debugPrint(
                "AccountReceivable Success: ${state.accountsReceivablesMainResEntity.data?.message}");
          }
          if (state is TotalIncomesSuccessState) {
            debugPrint(
                "TotalIncome Success: ${state.totalIncomesMainResEntity.data?.data?.length}");
            totalIncomes = state.totalIncomesMainResEntity.data?.data ?? [];
            totalIncomesCurrencies = totalIncomes.map((returnedIncome) {
              return returnedIncome.currency ?? "";
            }).toList();

            debugPrint("done TotalIncome");
          }
          if (state is TotalReceivablesSuccessState) {
            debugPrint(
                "TotalReceivable Success: ${state.totalReceivablesMainResEntity.data?.message}");
          }
          if (state is SalesExpensesSuccessState) {
            debugPrint(
                "Sales Expenses: ${state.salesExpensesMainResEntity.data?.message}");
          }

          if (state is OverdueInvoicesSuccessState) {
            debugPrint(
                "Overdue Invoice: ${state.overdueInvoiceMainResEntity.data?.message}");
            overDueInvoices =
                state.overdueInvoiceMainResEntity.data?.invoices ?? [];
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  OverdueInvoceWidget(
                    mainTitle: "Overdue Invoices",
                    overdueInvoices: overDueInvoices,
                  ),
                  AppConstants.sizeBoxHeight15,
                  TotalInvoiceWidget(
                    currenries: totalIncomesCurrencies,
                    totalIncomes: totalIncomes,
                  ),
                  AppConstants.sizeBoxHeight15,
                  TotalReceivablesWidget(),
                  AppConstants.sizeBoxHeight15,
                  AccountsReceivables(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

*/