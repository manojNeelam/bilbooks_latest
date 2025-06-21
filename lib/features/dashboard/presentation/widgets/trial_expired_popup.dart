import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TrialExpiredPopup extends StatelessWidget {
  final Function(String)? onOpenUrl;
  const TrialExpiredPopup({super.key, this.onOpenUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppPallete.kF2F2F2,
        ),
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      // Close button in top right
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          color: AppPallete.black,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),

                      // Add top padding so text does not overlap with close button
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0), // match close button height
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      5.0), // prevent text from being clipped
                              child: Text(
                                "Your trial has expired.",
                                style: AppFonts.mediumStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Thank you for giving Billbooks a try. Kindly select a plan to continue being a Billbooker.",
                    style: AppFonts.regularStyle(size: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Basic Plan",
                    style: AppFonts.mediumStyle(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (onOpenUrl != null) {
                        onOpenUrl!("https://app.billbooks.com/subscriptions");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return AppPallete.blueColor;
                          }
                          return AppPallete.blueColor;
                        },
                      ),
                      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return Colors.white;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Text(
                        "Pay Monthly\n\$7.95".toUpperCase(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    "or",
                    style: AppFonts.regularStyle(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (onOpenUrl != null) {
                        onOpenUrl!("https://app.billbooks.com/subscriptions");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return AppPallete.blueColor;
                          }
                          return AppPallete.blueColor;
                        },
                      ),
                      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return Colors.white;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Text(
                        "PAY ANNUALLY\n\$85.86 (Save 10%)",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Not sure? ",
                              style: AppFonts.regularStyle(size: 14)),
                          TextSpan(
                            text: "view other plans",
                            style: AppFonts.regularStyle(
                              color: AppPallete.blueColor,
                              size: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (onOpenUrl != null) {
                                  onOpenUrl!(
                                      "https://app.billbooks.com/subscriptions");
                                }
                              },
                          ),
                          TextSpan(
                              text: " or ",
                              style: AppFonts.regularStyle(size: 14)),
                          TextSpan(
                            text: "contact support",
                            style: AppFonts.regularStyle(
                              color: AppPallete.blueColor,
                              size: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (onOpenUrl != null) {
                                  onOpenUrl!(
                                      "https://www.billbooks.com/support/");
                                }
                              },
                          ),
                        ])),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
