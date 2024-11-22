import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:flutter/material.dart';

class PaymentItemWidget extends StatelessWidget {
  final PaymentEntity paymentEntity;
  const PaymentItemWidget({
    super.key,
    required this.paymentEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      paymentEntity.methodName ?? "",
                      style: AppFonts.regularStyle(),
                    ),
                    Text(
                      paymentEntity.amount ?? "",
                      style: AppFonts.mediumStyle(size: 16),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      paymentEntity.notes ?? "",
                      style: AppFonts.regularStyle(
                          size: 14, color: AppPallete.k666666),
                    ),
                    Text(
                      (paymentEntity.dateYmd ?? DateTime.now()).getDateString(),
                      style: AppFonts.regularStyle(
                          size: 14, color: AppPallete.k666666),
                    )
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
}
