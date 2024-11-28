import 'dart:ffi';

import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/sales_expenses_entity.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/sales_expenses_usecase.dart';
import '../../model/sales_types.dart';
import '../bloc/salesexpenses_bloc.dart';

class SalesexpensesWidget extends StatefulWidget {
  const SalesexpensesWidget({super.key});
  /*
  final Function(EnumSummaryTypes, String) onSelectedMenuItem;
  final EnumSummaryTypes? selectedMenuItem;
  const SalesexpensesWidget(
      {super.key, required this.onSelectedMenuItem, this.selectedMenuItem});
  */

  @override
  State<SalesexpensesWidget> createState() => _SalesexpensesWidgetState();
}

class _SalesexpensesWidgetState extends State<SalesexpensesWidget> {
  TotalsEntity? totalsEntity;
  final CustomPopupMenuController _controller = CustomPopupMenuController();
  List<EnumSummaryTypes> menuItems = [
    EnumSummaryTypes.last30Days,
    EnumSummaryTypes.thisMonth,
    EnumSummaryTypes.lastMonth,
    EnumSummaryTypes.thisQuater,
    EnumSummaryTypes.lastQuater,
    EnumSummaryTypes.thisYear,
    EnumSummaryTypes.lastYear,
  ];
  EnumSummaryTypes selectedSummaryType = EnumSummaryTypes.last30Days;

  double getTotal() {
    var sales = 0.0;
    var expenses = 0.0;
    var receipts = 0.0;

    if (totalsEntity?.sales != null) {
      if (totalsEntity?.sales is double) {
        sales = totalsEntity?.sales;
      } else if (totalsEntity?.sales is String) {
        sales = double.parse(totalsEntity?.sales);
      } else {
        sales = 0.0;
      }
    }

    // if (totalsEntity?.expenses != null) {
    //   if (totalsEntity?.expenses is double) {
    //     expenses = totalsEntity?.expenses;
    //   } else if (totalsEntity?.expenses is String) {
    //     expenses = double.parse(totalsEntity?.expenses);
    //   } else {
    //     expenses = 0.0;
    //   }
    // }

    if (totalsEntity?.receipts != null) {
      if (totalsEntity?.receipts is double) {
        receipts = totalsEntity?.receipts;
      } else if (totalsEntity?.receipts is String) {
        receipts = double.parse(totalsEntity?.receipts);
      } else {
        receipts = 0.0;
      }
    }
    return sales + expenses + receipts;
  }

  double getValue(EnumSalesType type) {
    if (totalsEntity == null) {
      return 0.0;
    }

    var sales = 0.0;
    if (totalsEntity?.sales is String) {
      sales = double.parse((totalsEntity?.sales as String));
    } else if (totalsEntity?.sales is double) {
      sales = (totalsEntity?.sales as double);
    } else {
      sales = 0.0;
    }

    var expenses = 0.0;
    if (totalsEntity?.expenses is String) {
      expenses = double.parse((totalsEntity?.expenses as String));
    } else if (totalsEntity?.expenses is double) {
      expenses = (totalsEntity?.expenses as double);
    } else {
      expenses = 0.0;
    }

    var receipts = 0.0;
    if (totalsEntity?.receipts is String) {
      receipts = double.parse((totalsEntity?.receipts as String));
    } else if (totalsEntity?.receipts is double) {
      receipts = (totalsEntity?.receipts as double);
    } else {
      receipts = 0.0;
    }

    final total = sales + expenses + receipts;

    switch (type) {
      case EnumSalesType.sales:
        return ((sales / total) * 360);
      case EnumSalesType.receipts:
        return (receipts / total) * 360;
      case EnumSalesType.expenses:
        return (expenses / total) * 360;
    }
  }

  PieChartData getPieChartData() {
    return PieChartData(
        centerSpaceRadius: 0,
        titleSunbeamLayout: true,
        pieTouchData: PieTouchData(enabled: true),
        sections: [
          PieChartSectionData(
              showTitle: false,
              radius: 120,
              value: 100,
              color: AppPallete.blueColor),
          PieChartSectionData(
              showTitle: false,
              radius: 120,
              value: getValue(EnumSalesType.receipts).ceilToDouble(),
              color: AppPallete.greenColor),
          PieChartSectionData(
              showTitle: false,
              radius: 120,
              value: getValue(EnumSalesType.expenses).ceilToDouble(),
              color: AppPallete.red)
        ]);
  }

  @override
  void initState() {
    //selectedSummaryType =
    //  widget.selectedMenuItem ?? EnumSummaryTypes.last30Days;
    _callApi();
    super.initState();
  }

  void _callApi() {
    context
        .read<SalesexpensesBloc>()
        .add(GetSalesExpensesEvent(params: SalesExpensesUsecaseReqParams()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          boxShadow: AppConstants.dashBoardItemSadow,
          borderRadius: BorderRadius.circular(5),
          color: AppPallete.white),
      child: BlocConsumer<SalesexpensesBloc, SalesexpensesState>(
        listener: (context, state) {
          if (state is SalesExpensesSuccessState) {
            totalsEntity = state.salesExpensesMainResEntity.data?.data?.totals;
          }
        },
        builder: (context, state) {
          if (state is SalesExpensesLoadingState) {
            return const SizedBox(
                height: 100,
                child: LoadingPage(title: "Loading sales expenses data"));
          }
          if (state is SalesExpensesSuccessState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Summary".toUpperCase(),
                      style: AppFonts.regularStyle(),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: CustomPopupMenu(
                          position: PreferredPosition.bottom,
                          arrowSize: 20,
                          arrowColor: AppPallete.white,
                          menuBuilder: () {
                            return SalesPopOverContentWidget(
                              menuItems: menuItems,
                              selectedItem: selectedSummaryType,
                              onSelectItem: (val) {
                                debugPrint(val.title);
                                debugPrint(
                                    "Formatted Date: ${val.displayName}");
                                selectedSummaryType = val;
                                //widget.onSelectedMenuItem(val, val.displayName);
                                setState(() {});
                                _controller.hideMenu();
                              },
                            );
                          },
                          menuOnChange: (updated) {},
                          verticalMargin: -10,
                          pressType: PressType.singleClick,
                          controller: _controller,
                          child: Text(
                            selectedSummaryType.displayName,
                            style: AppFonts.regularStyle(
                              color: AppPallete.blueColor,
                            ),
                          ),
                        )),
                  ],
                ),

                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: (getTotal() > 0)
                          ? PieChart(
                              getPieChartData(),
                              swapAnimationDuration:
                                  const Duration(milliseconds: 500), // Optional
                              swapAnimationCurve: Curves.easeInOut, // Optional
                            )
                          : Center(
                              child: Text(
                                "No sales, receipts and expenses to display",
                                textAlign: TextAlign.center,
                                style: AppFonts.regularStyle(
                                    color: AppPallete.k666666),
                              ),
                            ),
                    ),
                    Column(
                      children: [
                        legendWidget(context, EnumSalesType.sales,
                            (totalsEntity?.sales ?? 0.0).toString()),
                        legendWidget(context, EnumSalesType.receipts,
                            (totalsEntity?.receipts ?? 0.0).toString()),
                        legendWidget(context, EnumSalesType.expenses,
                            (totalsEntity?.expenses ?? 0.0).toString())
                      ],
                    )
                  ],
                ),
                // if (getTotal() == 0)
                // Text(
                //   "No sales and expenses to display",
                //   style: AppFonts.regularStyle(color: AppPallete.k666666),
                // ),
              ],
            );
          }
          return const SizedBox(
            height: 100,
          );
        },
      ),
    );
  }

  Widget legendWidget(BuildContext context, EnumSalesType type, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: type.color),
            ),
            AppConstants.sizeBoxWidth10,
            Text(
              type.title,
              style: AppFonts.regularStyle(),
            ),
          ],
        ),
        Text(
          "\$$amount",
          style: AppFonts.regularStyle(),
        )
      ],
    );
  }
}

enum EnumSalesType { sales, receipts, expenses }

extension EnumSalesTypeExt on EnumSalesType {
  String get title {
    switch (this) {
      case EnumSalesType.sales:
        return "Sales";
      case EnumSalesType.receipts:
        return "Receipts";
      case EnumSalesType.expenses:
        return "Expenses";
    }
  }

  Color get color {
    switch (this) {
      case EnumSalesType.sales:
        return AppPallete.blueColor;
      case EnumSalesType.receipts:
        return AppPallete.greenColor;
      case EnumSalesType.expenses:
        return AppPallete.red;
    }
  }
}

class SalesPopOverContentWidget extends StatelessWidget {
  const SalesPopOverContentWidget({
    super.key,
    required this.menuItems,
    required this.selectedItem,
    required this.onSelectItem,
  });

  final List<EnumSummaryTypes> menuItems;
  final EnumSummaryTypes selectedItem;
  final Function(EnumSummaryTypes) onSelectItem;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: const Color(0xFF4C4C4C),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menuItems
                .map(
                  (item) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onSelectItem(item);
                    },
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(item.title,
                                style: AppFonts.regularStyle()),
                          ),
                          AppConstants.sizeBoxWidth10,
                          if (selectedItem == item)
                            const Icon(
                              Icons.check,
                              color: AppPallete.blueColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
