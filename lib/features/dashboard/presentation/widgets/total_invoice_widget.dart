import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/main.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../domain/entity/total_incomes_entity.dart';
import '../../domain/usecase/total_incomes_usecase.dart';
import '../bloc/totalincomes_bloc.dart';

class TotalInvoiceWidget extends StatefulWidget {
  final TotalinvoicesBuilder builder;

  const TotalInvoiceWidget({super.key, required this.builder});

  @override
  State<TotalInvoiceWidget> createState() => _TotalInvoiceWidgetState();
}

class _TotalInvoiceWidgetState extends State<TotalInvoiceWidget> {
  TotalIncomesMainDataEntity? selectedItem;
  List<TotalIncomesMainDataEntity> totalIncomes = [];
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
      return selectedItem?.details?.today ?? "";
    }
    if (index == 1) {
      return selectedItem?.details?.thisWeek ?? "";
    }
    if (index == 2) {
      return selectedItem?.details?.thisMonth ?? "";
    }
    if (index == 3) {
      return selectedItem?.details?.thisQuarter ?? "";
    }
    if (index == 4) {
      return selectedItem?.details?.thisFiscalYear ?? "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, _callApi);

    return Container(
      //constraints: BoxConstraints(minHeight: 60, maxHeight: 280),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          boxShadow: AppConstants.dashBoardItemSadow,
          borderRadius: BorderRadius.circular(5),
          color: AppPallete.white),
      //height: 280,
      child: BlocConsumer<TotalincomesBloc, TotalincomesState>(
        listener: (context, state) {
          if (state is TotalIncomesSuccessState) {
            totalIncomes = state.totalIncomesMainResEntity.data?.data ?? [];
            selectedItem = totalIncomes.firstOrNull;
            // totalIncomesCurrencies = totalIncomes.map((returnedIncome) {
            //   return returnedIncome.currency ?? "";
            // }).toList();
          }
        },
        builder: (context, state) {
          if (state is TotalIncomesLoadingState) {
            return const SizedBox(
                height: 100,
                child: LoadingPage(title: "Loading total incomes..."));
          }
          if (state is TotalIncomesErrorState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Incomes'.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: AppFonts.regularStyle(),
                ),
                Text(
                  state.errorMessage,
                  style: AppFonts.regularStyle(),
                ),
              ],
            );
          }
          if (state is TotalIncomesSuccessState) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Incomes'.toUpperCase(),
                      style: AppFonts.regularStyle(),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: CustomPopupMenu(
                            position: PreferredPosition.bottom,
                            arrowSize: 20,
                            arrowColor: AppPallete.white,
                            menuBuilder: () {
                              return TotalInvoicePopOverWidget(
                                totalIncomes: totalIncomes,
                                currentSelectedItem: selectedItem!,
                                onSelectItem: (returnedItem) {
                                  selectedItem = returnedItem;
                                  setState(() {});
                                  _controller.hideMenu();
                                },
                              );
                            },
                            menuOnChange: (updated) {},
                            verticalMargin: -10,
                            pressType: PressType.singleClick,
                            controller: _controller,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  selectedItem?.currency ?? "",
                                  style: AppFonts.regularStyle(
                                    color: AppPallete.blueColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppPallete.blueColor50,
                                )
                              ],
                            ))),
                  ],
                ),
                AppConstants.sizeBoxHeight15,
                if (selectedItem != null)
                  SizedBox(
                    height: incomesList.length * 41,
                    child: ListView.builder(
                        //shrinkWrap: true,
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
            width: 400,
          );
        },
      ),
    );
  }
}

class TotalInvoicePopOverWidget extends StatelessWidget {
  final List<TotalIncomesMainDataEntity> totalIncomes;
  final TotalIncomesMainDataEntity currentSelectedItem;
  final Function(TotalIncomesMainDataEntity?) onSelectItem;

  const TotalInvoicePopOverWidget(
      {super.key,
      required this.totalIncomes,
      required this.currentSelectedItem,
      required this.onSelectItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: const Color(0xFF4C4C4C),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: totalIncomes
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
                            child: Text(item.currency ?? "",
                                style: AppFonts.regularStyle()),
                          ),
                          AppConstants.sizeBoxWidth10,
                          if (currentSelectedItem.currency == item.currency)
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
