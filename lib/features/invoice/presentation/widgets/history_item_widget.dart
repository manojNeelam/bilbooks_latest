import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:flutter/material.dart';

class HistoryItemWidget extends StatelessWidget {
  final InvoiceHistoryEntity historyEntity;
  final bool showViewHstory;
  final Function()? onPressViewHistory;

  const HistoryItemWidget({
    super.key,
    this.showViewHstory = false,
    this.onPressViewHistory,
    required this.historyEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: AppConstants.verticalPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppPallete.blueColor),
                  ),
                ),
                AppConstants.sizeBoxWidth10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        historyEntity.date ?? "",
                        style: AppFonts.regularStyle(color: AppPallete.k666666),
                      ),
                      Text(
                        historyEntity.description ?? "",
                        style: AppFonts.regularStyle(),
                      ),
                      Text(
                        "by ${historyEntity.createdBy ?? ""}",
                        style: AppFonts.regularStyle(color: AppPallete.k666666),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const ItemSeparator(),
          if (showViewHstory)
            TextButton(
                onPressed: onPressViewHistory,
                child: Text(
                  "View History",
                  textAlign: TextAlign.end,
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
        ],
      ),
    );
  }
}
