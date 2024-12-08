import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/dashboard/presentation/widgets/salesexpenses_widget.dart';
import 'package:billbooks_app/main.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../domain/entity/total_incomes_entity.dart';
import '../../domain/usecase/total_incomes_usecase.dart';
import '../bloc/totalincomes_bloc.dart';
import 'dropdown_view.dart';

class TotalInvoiceWidget extends StatefulWidget {
  final TotalinvoicesBuilder builder;

  const TotalInvoiceWidget({super.key, required this.builder});

  @override
  State<TotalInvoiceWidget> createState() => _TotalInvoiceWidgetState();
}

class _TotalInvoiceWidgetState extends State<TotalInvoiceWidget> {
  TotalIncomesEntity? selectedItem;
  List<TotalIncomesEntity> totalIncomes = [];
  List<String> totalIncomesCurrencies = [];
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  List<String> incomesList = [
    "Today",
    "This Week",
    "This Month",
    "This Quarter",
    "This Fiscal Year"
  ];

  @override
  void initState() {
    _callApi();
    super.initState();
  }

  void _callApi() {
    context
        .read<TotalincomesBloc>()
        .add(GetTotalIncomesEvent(params: TotalIncomesUsecaseReqParams()));
  }

  String getValueForIndex(int index) {
    if (selectedItem == null) {
      return "Its Null";
    }
    if (index == 0) {
      return selectedItem?.today ?? "";
    }
    if (index == 1) {
      return selectedItem?.thisWeek ?? "";
    }
    if (index == 2) {
      return selectedItem?.thisMonth ?? "";
    }
    if (index == 3) {
      return selectedItem?.thisQuarter ?? "";
    }
    if (index == 4) {
      return selectedItem?.thisFiscalYear ?? "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, _callApi);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          boxShadow: AppConstants.dashBoardItemSadow,
          borderRadius: BorderRadius.circular(5),
          color: AppPallete.white),
      height: 280,
      child: BlocConsumer<TotalincomesBloc, TotalincomesState>(
        listener: (context, state) {
          if (state is TotalIncomesSuccessState) {
            totalIncomes = state.totalIncomesMainResEntity.data?.data ?? [];
            selectedItem = totalIncomes.firstOrNull;
            totalIncomesCurrencies = totalIncomes.map((returnedIncome) {
              return returnedIncome.currency ?? "";
            }).toList();
          }
        },
        builder: (context, state) {
          if (state is TotalIncomesLoadingState) {
            return const SizedBox(
                height: 100,
                child: LoadingPage(title: "Loading total incomes..."));
          }
          if (state is TotalIncomesSuccessState) {
            return Column(
              children: [
                DropdownView(
                  title: 'Total Incomes'.toUpperCase(),
                  defaultText: '-',
                  value: selectedItem?.currency ?? "",
                  dropDownColor: AppPallete.blueColor,
                  dropDownIconColor: AppPallete.blueColor50,
                  onPress: () {
                    CustomPopupMenu(
                      position: PreferredPosition.bottom,
                      arrowSize: 20,
                      arrowColor: AppPallete.white,
                      menuBuilder: () {
                        return Text("");
                        // return TotalInvoicePopOverWidget(
                        //   menuItems: totalIncomesCurrencies,
                        //   selectedItem: selectedSummaryType,
                        //   onSelectItem: (val) {
                        //     //debugPrint(val.title);
                        //     //debugPrint("Formatted Date: ${val.displayName}");
                        //     // selectedSummaryType = val;
                        //     // startDatePrams = val.displayName.$1;
                        //     // endDateParams = val.displayName.$2;
                        //     //widget.onSelectedMenuItem(val, val.displayName);
                        //     setState(() {});
                        //     _controller.hideMenu();

                        //     //_callApi();
                        //   },
                        // );
                      },
                      menuOnChange: (updated) {},
                      verticalMargin: -10,
                      pressType: PressType.singleClick,
                      controller: _controller,
                      child: Text(
                        "",
                        style: AppFonts.regularStyle(
                          color: AppPallete.blueColor,
                        ),
                      ),
                    );
                  },
                ),
                AppConstants.sizeBoxHeight15,
                if (selectedItem != null)
                  Flexible(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: incomesList.length,
                        itemBuilder: (context, index) {
                          String title = incomesList[index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      title,
                                      style: AppFonts.regularStyle(),
                                    ),
                                    Text(
                                      getValueForIndex(index),
                                      style: AppFonts.mediumStyle(size: 16),
                                    )
                                  ],
                                ),
                              ),
                              if (incomesList.length > (index + 1))
                                const ItemSeparator()
                            ],
                          );
                        }),
                  )
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
}

// class TotalInvoicePopOverWidget extends StatelessWidget {
//   final List<String> 
//   const TotalInvoicePopOverWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
