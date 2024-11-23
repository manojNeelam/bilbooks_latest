import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/constants/assets.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class PlanExpiredPage extends StatelessWidget {
  const PlanExpiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(Icons.close)),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(Assets.assetsImagesExpired),
                AppConstants.sizeBoxHeight15,
                Text(
                  "Your trial has expired.",
                  style: AppFonts.mediumStyle(color: AppPallete.red, size: 25),
                ),
                AppConstants.sizeBoxHeight15,
                Text(
                  "Thank you for giving Billbooks a try. Kindly\nselect a plan to continue being a\nBillbooker.",
                  style: AppFonts.regularStyle(size: 17),
                  textAlign: TextAlign.center,
                ),
                AppConstants.sizeBoxHeight15,
                Text(
                  "Basic Plan",
                  style: AppFonts.mediumStyle(),
                ),
                AppConstants.sizeBoxHeight15,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.blueColor,
                        //foregroundColor: AppPallete.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: Text(
                      "PAY MONTHLY \n\$7.95",
                      style: AppFonts.regularStyle(color: AppPallete.white),
                      textAlign: TextAlign.center,
                    )),
                AppConstants.sizeBoxHeight15,
                Text(
                  "or",
                  style: AppFonts.regularStyle(size: 18),
                ),
                AppConstants.sizeBoxHeight15,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.blueColor,
                        //foregroundColor: AppPallete.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: Text(
                      "PAY ANNUALLY \n\$85.86(Save 10%)",
                      style: AppFonts.regularStyle(color: AppPallete.white),
                      textAlign: TextAlign.center,
                    )),
                AppConstants.sizeBoxHeight15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Not sure?",
                      style: AppFonts.regularStyle(size: 18),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        " view other plans",
                        style:
                            AppFonts.regularStyle(color: AppPallete.blueColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
