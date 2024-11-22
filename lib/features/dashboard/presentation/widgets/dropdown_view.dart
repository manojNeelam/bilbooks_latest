import 'package:flutter/material.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';

class DropdownView extends StatelessWidget {
  final String title;
  final String defaultText;
  final String value;
  final Color dropDownColor;
  final Color dropDownIconColor;
  final VoidCallback onPress;

  const DropdownView({
    Key? key,
    required this.title,
    required this.defaultText,
    this.value = "",
    this.dropDownColor = AppPallete.textColor,
    this.dropDownIconColor = AppPallete.borderColor,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppFonts.regularStyle(),
              ),
              GestureDetector(
                onTap: onPress,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      value.isEmpty ? defaultText : value,
                      textAlign: TextAlign.right,
                      style: AppFonts.regularStyle(color: dropDownColor),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: dropDownIconColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
