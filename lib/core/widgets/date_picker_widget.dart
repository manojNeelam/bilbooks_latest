import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

Future<DateTime?> buildMaterialDatePicker(
    BuildContext context, DateTime initialDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppPallete.blueColor, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.black, //// <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppPallete.blueColor, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (picked != null && picked != initialDate) {
    return picked;
  }
  return null;
}
