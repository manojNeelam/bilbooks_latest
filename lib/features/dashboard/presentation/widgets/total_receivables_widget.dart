import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/main.dart';
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
    if (selectedItem == null) {
      return "Its Null";
    }
    if (index == 0) {
      return selectedItem?.today.toString() ?? "";
    }
    if (index == 1) {
      return selectedItem?.the90Days.toString() ?? "";
    }
    if (index == 2) {
      return selectedItem?.the130Days.toString() ?? "";
    }
    if (index == 3) {
      return selectedItem?.the130Days.toString() ?? "";
    }
    if (index == 4) {
      return selectedItem?.the3160Days.toString() ?? "";
    }
    return "Hello";
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
          if (state is TotalReceivablesSuccessState) {
            return Column(
              children: [
                DropdownView(
                  title: 'Total Receivables'.toUpperCase(),
                  defaultText: 'AUD',
                  dropDownColor: AppPallete.blueColor,
                  dropDownIconColor: AppPallete.blueColor50,
                  onPress: () {},
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
          );
        },
      ),
    );
  }
}
