import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';

class OnlinePaymentHeaderWidget extends StatelessWidget {
  final String title;
  const OnlinePaymentHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.verticalPadding13,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.regularStyle(color: AppPallete.k666666, size: 14)
                .copyWith(decoration: TextDecoration.underline),
          ),
          Text(
            "Transaction charges are applicable as per your payment gateway’s plan. No addisional fee will be charged by Billbooks.",
            style: AppFonts.regularStyle(color: AppPallete.k666666, size: 14),
          )
        ],
      ),
    );
  }
}
