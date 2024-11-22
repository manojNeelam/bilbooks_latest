import 'package:billbooks_app/core/app_constants.dart';
import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'item_separator.dart';

class InputDropdownView extends StatelessWidget {
  final bool isRequired;
  final String title;
  final String defaultText;
  final bool showDivider;
  final String value;
  final VoidCallback onPress;
  final bool showDropdownIcon;
  final IconData dropDownImageName;
  final bool isDisabled;
  final bool isMediumFont;

  const InputDropdownView({
    Key? key,
    this.isRequired = true,
    required this.title,
    required this.defaultText,
    this.showDivider = true,
    this.value = "",
    this.isMediumFont = false,
    required this.onPress,
    this.showDropdownIcon = true,
    this.dropDownImageName = Icons.arrow_drop_down,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 32;
    final double valueWidth = screenWidth - 210;
    const double titleWidth = 160;

    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: AppConstants.contentViewPadding,
                  width: titleWidth,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                      style: AppFonts.regularStyle(),
                      text: title,
                      children: [
                        if (isRequired)
                          TextSpan(
                              text: " *",
                              style: AppFonts.regularStyle()
                                  .copyWith(color: AppPallete.red))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: isDisabled ? null : onPress,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                        width: valueWidth,
                        child: Text(
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          value.isEmpty ? defaultText : value,
                          textAlign: TextAlign.right,
                          style: isMediumFont
                              ? AppFonts.mediumStyle(
                                  size: 16,
                                  color: isDisabled
                                      ? AppPallete.borderColor
                                      : value.isEmpty
                                          ? AppPallete.borderColor
                                          : AppPallete.textColor)
                              : AppFonts.regularStyle(
                                  color: isDisabled
                                      ? AppPallete.borderColor
                                      : value.isEmpty
                                          ? AppPallete.borderColor
                                          : AppPallete.textColor),
                        ),
                      ),
                      if (showDropdownIcon)
                        Icon(
                          dropDownImageName,
                          color: AppPallete.borderColor,
                        )
                    ],
                  ),
                )
              ],
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            if (showDivider) const ItemSeparator(),
          ],
        ),
      ),
    );
  }
}
