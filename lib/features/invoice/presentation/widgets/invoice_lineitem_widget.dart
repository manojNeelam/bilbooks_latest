import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class InvoiceLineitemWidget extends StatelessWidget {
  final InvoiceItemEntity itemListEntity;
  const InvoiceLineitemWidget({super.key, required this.itemListEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstants.sizeBoxHeight15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (itemListEntity.itemName ?? "-").capitalize(),
                style: AppFonts.mediumStyle(size: 16),
              ),
              Text(
                "\$${itemListEntity.amount}",
                style: AppFonts.mediumStyle(size: 16),
              )
            ],
          ),
          AppConstants.sepSizeBox5,
          Text(
            getDesc(),
            style: AppFonts.regularStyle(size: 14, color: AppPallete.k666666),
          ),
          AppConstants.sepSizeBox5,
          Row(
            children: [
              CapsuleStatusWidget(
                  title: "${itemListEntity.qty}",
                  backgroundColor: AppPallete.kF2F2F2,
                  textColor: AppPallete.k666666),
              AppConstants.sizeBoxWidth5,
              Text(
                "x\$${itemListEntity.rate}",
                style:
                    AppFonts.regularStyle(color: AppPallete.k666666, size: 14),
              ),
            ],
          ),
          AppConstants.sizeBoxHeight15,
          const ItemSeparator()
        ],
      ),
    );
  }

  bool isGoods() {
    return itemListEntity.type?.toLowerCase() == "goods";
  }

  String getDesc() {
    if (itemListEntity.description == null) {
      return "-";
    }
    if (itemListEntity.description != null &&
        itemListEntity.description!.isNotEmpty) {
      return itemListEntity.description!.capitalize();
    }
    return "-";
  }
}
