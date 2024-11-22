import 'package:billbooks_app/core/app_constants.dart';
import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'item_separator.dart';

class NewInputViewWidget extends StatelessWidget {
  final bool isRequired;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool showDivider;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Function(String?)? onChanged;
  final bool isBold;

  const NewInputViewWidget(
      {Key? key,
      this.isRequired = true,
      required this.title,
      required this.hintText,
      required this.controller,
      this.isBold = false,
      this.showDivider = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    keyboardType: inputType,
                    textInputAction: inputAction,
                    controller: controller,
                    textCapitalization: TextCapitalization.sentences,
                    style: isBold
                        ? AppFonts.mediumStyle(size: 16)
                        : AppFonts.regularStyle(),
                    onChanged: onChanged,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: AppConstants.contentViewPadding,
                        fillColor: AppPallete.white,
                        filled: true,
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: AppFonts.hintStyle()),
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
