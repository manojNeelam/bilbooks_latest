import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//fontFamily: "AktivGrotesk"
class AppTheme {
  static final themeData = ThemeData(fontFamily: "AktivGrotesk").copyWith(
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: AppPallete.blueColor),
        actionsIconTheme: const IconThemeData(color: AppPallete.blueColor),
        backgroundColor: AppPallete.white,
        centerTitle: true,
        titleTextStyle: AppFonts.mediumStyle()),
    scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    // textTheme: const TextTheme(
    //     bodyLarge: TextStyle(
    //         fontFamily: "AktivGrotesk",
    //         fontSize: 16,
    //         fontWeight: FontWeight.w500,
    //         color: AppPallete.textColor),
    //     titleMedium: TextStyle(
    //         fontFamily: "AktivGrotesk",
    //         fontSize: 28,
    //         fontWeight: FontWeight.w600,
    //         color: AppPallete.textColor)),
  );
}
