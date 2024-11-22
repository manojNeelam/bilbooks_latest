// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class OtherDetailsInputView extends StatelessWidget {
  final bool isRequired;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool showDivider;
  final TextInputType inputType;
  final TextInputAction inputAction;
  const OtherDetailsInputView({
    Key? key,
    this.isRequired = true,
    required this.title,
    required this.hintText,
    required this.controller,
    this.showDivider = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
  }) : super(key: key);

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
                    controller: controller,
                    textInputAction: inputAction,
                    style: AppFonts.regularStyle(),
                    decoration: InputDecoration(
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
