import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/utils/currency_helper.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/main.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../domain/entity/total_receivables_entity.dart';
import '../../domain/usecase/total_receivables_usecase.dart';
import '../bloc/totalreceivable_bloc.dart';
import 'dropdown_view.dart';

class TotalReceivablesWidget extends StatefulWidget {
  final TotalReceivablesBuilder builder;

  const TotalReceivablesWidget({super.key, required this.builder});

  @override
  State<TotalReceivablesWidget> createState() => _TotalReceivablesWidgetState();
}

class _TotalReceivablesWidgetState extends State<TotalReceivablesWidget> {
  List<TotalReceivablesEntity> totalIncomes = [];
  TotalReceivablesEntity? selectedItem;
  List<TotalReceivablesEntity> receivables = [];
  List<String> totalIncomesCurrencies = [];
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  List<String> incomesList = [
    "Today",
    "1-30 days",
    "30-60 Days",
    "60-90 Days",
    "> 90 Days"
  ];

  @override
  void initState() {
    _callApi();
    // totalIncomes = widget.totalIncomes;
    // debugPrint("widget.totalIncomes.length.toString()");
    // if (totalIncomes.isNotEmpty) selectedItem = totalIncomes.first;
    super.initState();
  }

  void _callApi() {
    context.read<TotalreceivableBloc>().add(
        GetTotalReceivablesEvent(params: TotalReceivablesUsecaseReqParams()));
  }

  String getValueForIndex(int index) {
    var currencyCode = selectedItem?.currency ?? "";
    final symbol = CurrencyHelper().getSymbolById(currencyCode);
    if (selectedItem == null) {
      return "Its Null";
    }
    if (index == 0) {
      return "$symbol ${selectedItem?.today.toString() ?? ""}";
    }
    if (index == 1) {
      return "$symbol ${selectedItem?.the90Days.toString() ?? ""}";
    }
    if (index == 2) {
      return "$symbol ${selectedItem?.the130Days.toString() ?? ""}";
    }

    if (index == 3) {
      return "$symbol ${selectedItem?.the130Days.toString() ?? ""}";
    }

    if (index == 4) {
      return "$symbol ${selectedItem?.the3160Days.toString() ?? ""}";
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
      child: BlocConsumer<TotalreceivableBloc, TotalreceivableState>(
        listener: (context, state) {
          if (state is TotalReceivablesSuccessState) {
            receivables = state.totalReceivablesMainResEntity.data?.data ?? [];
            selectedItem = receivables.firstOrNull;
            totalIncomesCurrencies = receivables.map((returnedItem) {
              return returnedItem.currency ?? "";
            }).toList();
          }
        },
        builder: (context, state) {
          if (state is TotalReceivablesLoadingState) {
            return const SizedBox(
                height: 100,
                child: LoadingPage(title: "Loading total receivables..."));
          }
          if (state is TotalReceivablesErrorState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Receivables'.toUpperCase(),
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

          if (state is TotalReceivablesSuccessState) {
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
                                totalIncomes: receivables,
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
                Flexible(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: incomesList.length,
                      itemBuilder: (context, index) {
                        String title = incomesList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
  final List<TotalReceivablesEntity> totalIncomes;
  final TotalReceivablesEntity currentSelectedItem;
  final Function(TotalReceivablesEntity?) onSelectItem;

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
