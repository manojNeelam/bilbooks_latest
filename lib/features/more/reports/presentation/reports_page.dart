import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/constants/assets.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum EnumReportsType {
  invoice,
  expenses,
  itemSales,
  collections,
  outstandings,
  salesTax,
  profitAndLoss
}

extension EnumReportsTypeExtension on EnumReportsType {
  (String title, String desc, String imageName) get details {
    switch (this) {
      case EnumReportsType.invoice:
        return (
          "Invoices Report",
          "A list of all invoices you have sent over \ntime.",
          Assets.assetsImagesIcReports
        );
      case EnumReportsType.expenses:
        return (
          "Expenses Report",
          "Analyse your expennses category wise.",
          Assets.assetsImagesIcReportsExpenses
        );
      case EnumReportsType.itemSales:
        return (
          "Item Sales Report",
          "A detailed summary of all items you’ve \nsold over time.",
          Assets.assetsImagesIcReportsExpenses
        );
      case EnumReportsType.collections:
        return (
          "Collections Report ",
          "A summary of all the payments you \nhave collected over time.",
          Assets.assetsImagesIcReportsCollections
        );
      case EnumReportsType.outstandings:
        return (
          "Outstandings Reports ",
          "Find out which clients have the most \noutstanding.",
          Assets.assetsImagesIcReportsOutstanding
        );
      case EnumReportsType.salesTax:
        return (
          "Sales Tax Summary",
          "Taxes collected from sales to help you \nfile sales tax returns.",
          Assets.assetsImagesIcReportsSales
        );
      case EnumReportsType.profitAndLoss:
        return (
          "Profit & Loss",
          "Review your income and expenses \nover time",
          Assets.assetsImagesIcReportsProfitLoss
        );
    }
  }
}

@RoutePage()
class MoreReportsPage extends StatelessWidget {
  const MoreReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<EnumReportsType> reports = [
      EnumReportsType.invoice,
      EnumReportsType.expenses,
      EnumReportsType.itemSales,
      EnumReportsType.collections,
      EnumReportsType.outstandings,
      EnumReportsType.salesTax,
      EnumReportsType.profitAndLoss
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            final (String name, String desc, String imageName) = report.details;
            return GestureDetector(
              onTap: () {
                debugPrint("Tapped item");
                switch (report) {
                  case EnumReportsType.invoice:
                    AutoRouter.of(context).push(const ReportInvoicePageRoute());
                  case EnumReportsType.expenses:
                    AutoRouter.of(context)
                        .push(const ReportExpensesPageRoute());
                  case EnumReportsType.itemSales:
                    AutoRouter.of(context)
                        .push(const ReportItemSalesPageRoute());
                  case EnumReportsType.collections:
                    AutoRouter.of(context)
                        .push(const ReportCollectionsPageRoute());
                  case EnumReportsType.outstandings:
                    AutoRouter.of(context)
                        .push(const ReportOutstandingsPageRoute());
                  case EnumReportsType.salesTax:
                    AutoRouter.of(context)
                        .push(const ReportSalesTaxPageRoute());
                  case EnumReportsType.profitAndLoss:
                    AutoRouter.of(context)
                        .push(const ReportProfitAndLossPageRoute());
                }
              },
              child: ReportItemWidget(
                  imageName: imageName, name: name, desc: desc),
            );
          }),
    );
  }
}

class ReportItemWidget extends StatelessWidget {
  const ReportItemWidget({
    super.key,
    required this.imageName,
    required this.name,
    required this.desc,
  });

  final String imageName;
  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageName,
            width: 25,
            height: 25,
          ),
          AppConstants.sizeBoxWidth10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppFonts.regularStyle(),
                ),
                Text(
                  desc,
                  style: AppFonts.regularStyle(
                      color: AppPallete.k666666, size: 14),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Icon(
              Icons.chevron_right,
              color: AppPallete.borderColor,
            ),
          )
        ],
      ),
    );
  }
}
