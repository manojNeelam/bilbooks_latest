// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:flutter/material.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';

class InputDiscountWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback callback;
  final bool isPercentage;
  final showDivider;
  final Function(String?)? onChanged;

  const InputDiscountWidget({
    Key? key,
    required this.controller,
    required this.callback,
    required this.isPercentage,
    this.showDivider = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Discount",
                  style: AppFonts.regularStyle(),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: onChanged,
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.end,
                    style: AppFonts.regularStyle(size: 16),
                    decoration: const InputDecoration(
                        contentPadding: AppConstants.contentViewPadding,
                        hintText: "0.00",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  ),
                ),
                AppConstants.sizeBoxWidth10,
                GestureDetector(
                  onTap: callback,
                  child: Container(
                    width: 35,
                    height: 30,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppPallete.blueColor, width: 1),
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle),
                    child: Center(
                      child: Text(
                        isPercentage ? "%" : "\$",
                        style: AppFonts.regularStyle(
                            color: AppPallete.blueColor, size: 14),
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (showDivider) const ItemSeparator()
          ],
        ),
      ),
    );
  }
}
