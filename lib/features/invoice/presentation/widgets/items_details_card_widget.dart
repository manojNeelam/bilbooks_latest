import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:flutter/material.dart';

class ItemDetailsCardWidget extends StatelessWidget {
  final InvoiceItemEntity invoiceItemEntity;
  final String currencySymbol;
  const ItemDetailsCardWidget(
      {super.key,
      required this.invoiceItemEntity,
      required this.currencySymbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      invoiceItemEntity.itemName ?? "",
                      style: AppFonts.mediumStyle(size: 16),
                    ),
                    Text(
                      "${currencySymbol}${invoiceItemEntity.amount}",
                      style: AppFonts.mediumStyle(size: 16),
                    ),
                  ],
                ),
                Text(
                  "${invoiceItemEntity.description}",
                  maxLines: 1,
                  style: AppFonts.regularStyle(
                      size: 14, color: AppPallete.k666666),
                ),
                Text(
                  "Date: ${invoiceItemEntity.date}",
                  style: AppFonts.regularStyle(
                      size: 14, color: AppPallete.k666666),
                ),
                Row(
                  children: [
                    CapsuleStatusWidget(
                        title: "${invoiceItemEntity.unit}",
                        backgroundColor: AppPallete.kF2F2F2,
                        textColor: AppPallete.k666666),
                    AppConstants.sizeBoxWidth10,
                    Text(
                      "x \$${invoiceItemEntity.rate}",
                      style: AppFonts.regularStyle(
                          color: AppPallete.k666666, size: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          const ItemSeparator(),
        ],
      ),
    );
  }
}
