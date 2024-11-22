import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../theme/app_fonts.dart';

void showToastification(
    BuildContext context, String title, ToastificationType type) {
  toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.regularStyle(),
      ),
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      primaryColor: type == ToastificationType.error
          ? AppPallete.red
          : AppPallete.greenColor,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      alignment: Alignment.bottomCenter);
}
