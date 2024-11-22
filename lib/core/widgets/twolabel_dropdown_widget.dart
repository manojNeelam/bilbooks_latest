import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:flutter/material.dart';

class TwoLabelsDropDownWidget extends StatelessWidget {
  final String title;
  final String value;
  final Function() onClickDropDown;
  final bool showDivider;
  const TwoLabelsDropDownWidget(
      {super.key,
      required this.showDivider,
      required this.title,
      required this.value,
      required this.onClickDropDown});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onClickDropDown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(color: AppPallete.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              AppFonts.regularStyle(color: AppPallete.k666666),
                        ),
                        Text(
                          value,
                          style: AppFonts.regularStyle(
                              color: AppPallete.textColor),
                        )
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppPallete.borderColor,
                  )
                ],
              ),
            ),
            if (showDivider) const ItemSeparator(),
          ],
        ),
      ),
    );
  }
}
