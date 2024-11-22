// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';

class NewclientAddressDetailsInputview extends StatelessWidget {
  final String title;
  final bool isRequired;
  final Function()? onPress;
  const NewclientAddressDetailsInputview({
    Key? key,
    required this.title,
    this.isRequired = true,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: const BoxDecoration(color: AppPallete.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
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
                  const Icon(Icons.chevron_right, color: AppPallete.borderColor)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
