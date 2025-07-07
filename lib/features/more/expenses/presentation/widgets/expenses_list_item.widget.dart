import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/more/expenses/domain/entities/expenses_list_entity.dart';
import 'package:flutter/material.dart';

class ExpensesListItemWidget extends StatelessWidget {
  final ExpenseEntity expenseEntity;
  const ExpensesListItemWidget({super.key, required this.expenseEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expenseEntity.categoryName ?? "",
                      style: AppFonts.regularStyle(),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      expenseEntity.vendor ?? "",
                      style: AppFonts.regularStyle(
                          size: 15, color: AppPallete.k666666),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Row(
                      children: [
                        CapsuleStatusWidget(
                            title: "#${expenseEntity.refno ?? "-"}",
                            backgroundColor: AppPallete.kF2F2F2,
                            textColor: AppPallete.k666666),
                        if (isRecurring())
                          Row(
                            children: [
                              AppConstants.sizeBoxWidth10,
                              Text(getFreqName()),
                              AppConstants.sizeBoxWidth10,
                              const CapsuleStatusWidget(
                                  title: "Active",
                                  backgroundColor: AppPallete.kF2F2F2,
                                  textColor: AppPallete.greenColor)
                            ],
                          )
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      expenseEntity.formatedAmount ?? "0.00",
                      style: AppFonts.mediumStyle(size: 16),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      expenseEntity.dateYmd?.getDateString() ?? "",
                      style: AppFonts.regularStyle(
                          size: 15, color: AppPallete.k666666),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      (expenseEntity.status ?? "").toUpperCase(),
                      style: AppFonts.regularStyle(
                          size: 13, color: expenseEntity.statusColor),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ItemSeparator()
        ],
      ),
    );
  }

  String getFreqName() {
    final freqName = expenseEntity.frequencyName ?? "";
    final howmany = expenseEntity.howmany ?? "";
    String howManyDisplay = "";
    if (howmany.isNotEmpty && howmany == "0") {
      howManyDisplay = "Infinite";
    } else {
      howManyDisplay = howmany;
    }

    return "$freqName ($howManyDisplay)";
  }

  bool isRecurring() {
    final status = expenseEntity.status ?? "";
    if (status.toLowerCase() == "recurring") {
      return true;
    }
    return false;
  }
}
