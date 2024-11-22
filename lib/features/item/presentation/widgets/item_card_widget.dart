import 'dart:async';

import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/item_separator.dart';

class ItemCardWidget extends StatelessWidget {
  final ItemListEntity itemListEntity;
  const ItemCardWidget({super.key, required this.itemListEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          AppConstants.sizeBoxHeight15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  maxLines: 2,
                  itemListEntity.name?.capitalize() ?? "-",
                  style: AppFonts.regularStyle(size: 16),
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  textAlign: TextAlign.end,
                  "\$${itemListEntity.rate ?? ""}",
                  style: AppFonts.mediumStyle(size: 16),
                ),
              )
            ],
          ),
          //AppConstants.sepSizeBox5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  maxLines: 2,
                  descriptionItem,
                  style: AppFonts.regularStyle(
                      size: 14, color: AppPallete.k666666),
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  itemListEntity.unit ?? "",
                  textAlign: TextAlign.end,
                  style: AppFonts.regularStyle(
                      size: 14, color: AppPallete.k666666),
                ),
              )
            ],
          ),
          AppConstants.sepSizeBox5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "#${itemListEntity.sku ?? ""}",
                    style: AppFonts.regularStyle(
                        size: 14, color: AppPallete.k666666),
                  ),
                  if (isGoods()) AppConstants.sizeBoxWidth10,
                  if (isGoods())
                    CapsuleStatusWidget(
                        title: "Stock: ${itemListEntity.stock.toString()}",
                        backgroundColor: AppPallete.kF2F2F2,
                        textColor: isHighStock()
                            ? AppPallete.greenColor
                            : AppPallete.red),
                  if (isActive() == false) AppConstants.sizeBoxWidth10,
                  if (isActive() == false)
                    const CapsuleStatusWidget(
                        title: "Inactive",
                        backgroundColor: AppPallete.kF2F2F2,
                        textColor: AppPallete.k666666)
                ],
              ),
              Text(
                itemListEntity.type?.toUpperCase() ?? "",
                style: AppFonts.mediumStyle(
                    size: 14,
                    color: isGoods()
                        ? AppPallete.blueColor
                        : AppPallete.greenColor),
              )
            ],
          ),
          AppConstants.sizeBoxHeight15,
          const ItemSeparator()
        ],
      ),
    );
  }

  String get descriptionItem {
    final desc = itemListEntity.description ?? "";
    if (desc.isNotEmpty) {
      return desc.capitalize();
    }
    return desc;
  }

  bool isActive() {
    final status = itemListEntity.status ?? "";
    if (status.toLowerCase() == "active") {
      return true;
    }
    return false;
  }

  bool isHighStock() {
    final stock = itemListEntity.stock ?? 0;
    if (stock > 0) {
      return true;
    }
    return false;
  }

  bool isGoods() {
    return itemListEntity.type?.toLowerCase() == "goods";
  }
}
