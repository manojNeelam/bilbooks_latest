import 'package:flutter/material.dart';
//50000
import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'item_separator.dart';

class NewMultilineInputWidget extends StatelessWidget {
  final bool isRequired;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool showDivider;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextCapitalization textCapitalization;
  const NewMultilineInputWidget({
    Key? key,
    this.isRequired = true,
    required this.title,
    required this.hintText,
    required this.controller,
    this.showDivider = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstants.sizeBoxHeight15,
          RichText(
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
          AppConstants.sizeBoxHeight10,
          TextFormField(
            controller: controller,
            textAlign: TextAlign.left,
            keyboardType: inputType,
            minLines: 3,
            maxLines: 10,
            textInputAction: inputAction,
            textCapitalization: textCapitalization,
            style: AppFonts.regularStyle(),
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 0),
                fillColor: AppPallete.white,
                filled: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: AppFonts.hintStyle()),
          ),
          AppConstants.sizeBoxHeight15,
          if (showDivider) const ItemSeparator(),
        ],
      ),
    );
  }
}
