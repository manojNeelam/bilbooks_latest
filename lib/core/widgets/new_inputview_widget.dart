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
  final bool isHideImage;
  final TextCapitalization textCapitalization;

  const NewInputViewWidget(
      {Key? key,
      this.isHideImage = false,
      this.isRequired = true,
      required this.title,
      required this.hintText,
      required this.controller,
      this.isBold = false,
      this.showDivider = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.onChanged,
      this.textCapitalization = TextCapitalization.none})
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
                Container(
                  constraints: BoxConstraints(maxWidth: 180),
                  child: Row(
                    children: [
                      Flexible(
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                      Wrap(children: [
                        AppConstants.sizeBoxWidth5,
                        if (isHideImage)
                          Icon(
                            Icons.visibility_off_rounded,
                            color: AppPallete.red,
                            size: 18,
                          )
                      ]),
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
                    textCapitalization: textCapitalization,
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
