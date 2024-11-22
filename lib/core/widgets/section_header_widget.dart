// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final bool? haveLeadingButton;
  final Function()? onTapLeadingButton;
  const SectionHeaderWidget({
    Key? key,
    required this.title,
    this.haveLeadingButton = false,
    this.onTapLeadingButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: AppPallete.kF2F2F2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style:
                  AppFonts.regularStyle(size: 14, color: AppPallete.textColor),
            ),
            if (haveLeadingButton ?? false)
              GestureDetector(
                onTap: () {
                  if (onTapLeadingButton != null) onTapLeadingButton!();
                },
                child: const Icon(
                  Icons.add_circle,
                  color: AppPallete.blueColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
