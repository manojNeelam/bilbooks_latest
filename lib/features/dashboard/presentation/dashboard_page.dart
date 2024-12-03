import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/gestures.dart';
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
  late void Function() updateSalesExpenses;
  late void Function() updateOverdueInvoiceMethod;
  late void Function() updateTotalInvoiceMethod;
  late void Function() updateTotalReceivablesMethod;
  late void Function() updateAccountReceivableMethod;

  AuthInfoMainDataEntity? authInfoMainDataEntity;
  @override
  void initState() {
    authInfoMainDataEntity = widget.authInfoMainDataEntity;
    super.initState();
  }

  bool isExpired() {
    var plan = authInfoMainDataEntity?.sessionData?.organization?.plan;
    if (plan == null) {
      return true;
    }
    var isPlanExpired = plan.isExpired ?? true;
    if (isPlanExpired) {
      return true;
    }
    return false;
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
                updateAuthInfo: (p0) {
                  authInfoMainDataEntity = p0;
                },
                refresh: () {
                  updateSalesExpenses.call();
                  updateAccountReceivableMethod.call();
                  updateOverdueInvoiceMethod.call();
                  updateTotalInvoiceMethod.call();
                  updateTotalReceivablesMethod.call();
                  //myMethod.call();
                  setState(() {});
                }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  (authInfoMainDataEntity?.sessionData?.organization?.name ??
                      ""),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isExpired())
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: "Hello",
                      style: AppFonts.regularStyle(
                          color: AppPallete.red, size: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                " ${authInfoMainDataEntity?.sessionData?.user?.firstname ?? ""}",
                            style: AppFonts.mediumStyle(
                                color: AppPallete.red, size: 16)),
                        TextSpan(
                            text: ", your trail has expired. ",
                            style: AppFonts.regularStyle(
                                color: AppPallete.red, size: 14)),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Utils.showTrailExpired(context),
                            text: "Choose a plane",
                            style: AppFonts.regularStyle(
                              color: AppPallete.blueColor,
                              size: 14,
                            ).copyWith(decoration: TextDecoration.underline)),
                        TextSpan(
                            text: " to resume services.",
                            style: AppFonts.regularStyle(
                                color: AppPallete.red, size: 14)),
                      ]),
                ),
              AppConstants.sizeBoxHeight15,
              SalesexpensesWidget(
                builder: (context, methodA) {
                  updateSalesExpenses = methodA;
                },
              ),
              AppConstants.sizeBoxHeight15,
              OverdueInvoceWidget(
                builder: (context, updateOverdueInvoice) {
                  updateOverdueInvoiceMethod = updateOverdueInvoice;
                },
              ),
              AppConstants.sizeBoxHeight15,
              TotalInvoiceWidget(
                builder: (context, updateTotalInvoice) {
                  updateTotalInvoiceMethod = updateTotalInvoice;
                },
              ),
              AppConstants.sizeBoxHeight15,
              TotalReceivablesWidget(
                builder: (context, updateTotalReceivables) {
                  updateTotalReceivablesMethod = updateTotalReceivables;
                },
              ),
              AppConstants.sizeBoxHeight15,
              AccountsReceivables(
                builder: (context, updateAccountReceivable) {
                  updateAccountReceivableMethod = updateAccountReceivable;
                },
              ),
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