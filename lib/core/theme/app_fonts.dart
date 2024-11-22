import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  // static TextStyle formTitleStyle() {
  //   return const TextStyle(
  //       color: AppPallete.textColor,
  //       fontWeight: FontWeight.w400,
  //       fontFamily: "AktivGrotesk",
  //       fontSize: 15);
  // }

  // static TextStyle formInputStyle() {
  //   return const TextStyle(
  //       color: AppPallete.textColor,
  //       fontWeight: FontWeight.w400,
  //       fontFamily: "AktivGrotesk-Regular",
  //       fontSize: 16);
  // }

  static TextStyle hintStyle() {
    return const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
        fontFamily: "AktivGrotesk",
        letterSpacing: 0.0,
        fontSize: 15);
  }

  static TextStyle authHeaderStyle() {
    return const TextStyle(
        color: AppPallete.black,
        fontWeight: FontWeight.w500,
        fontFamily: "AktivGrotesk-Medium",
        letterSpacing: 0.0,
        fontSize: 28);
  }

  static TextStyle textStyle() {
    return const TextStyle(
        color: AppPallete.k666666,
        fontWeight: FontWeight.w400,
        fontFamily: "AktivGrotesk-Regular",
        letterSpacing: 0.0,
        fontSize: 16);
  }

  static TextStyle mediumStyle(
      {double? size = 20, Color? color = AppPallete.textColor}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontFamily: "AktivGrotesk-Medium",
        letterSpacing: 0.0,
        fontSize: size);
  }

  static TextStyle boldStyle(
      {double? size = 20, Color? color = AppPallete.textColor}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontFamily: "AktivGrotesk-Bold",
        letterSpacing: 0.0,
        fontSize: size);
  }

  static TextStyle regularStyle(
      {double? size = 16, Color? color = Colors.black}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: "AktivGrotesk-Regular",
        letterSpacing: 0,
        fontSize: size);
  }

  static TextStyle buttonTextStyle(
      {double? size = 16, Color? color = AppPallete.blueColor}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: "AktivGrotesk-Regular",
        letterSpacing: 0.0,
        fontSize: size);
//     font-family: AktivGrotesk-Regular;
// font-size: 16px;
// font-style: normal;
// font-weight: 400;
// line-height: normal;
  }

  // static TextStyle textSize10({
  //   Color? color,
  //   FontWeight? fontWeight,
  // }) {
  //   return _baseFont(
  //     color: color ?? Colors.black,
  //     fontWeight: fontWeight ?? FontWeight.w700,
  //     fontSize: 10.0,
  //   );
  // }

  // static TextStyle textSize12({
  //   Color? color,
  //   FontWeight? fontWeight,
  // }) {
  //   return _baseFont(
  //     color: color ?? Colors.black,
  //     fontWeight: fontWeight ?? FontWeight.normal,
  //     fontSize: 12.0,
  //   );
  // }

  // static TextStyle textSize16({
  //   Color? color,
  //   FontWeight? fontWeight,
  // }) {
  //   return _baseFont(
  //     color: color ?? Colors.black,
  //     fontWeight: fontWeight ?? FontWeight.normal,
  //     fontSize: 16.0,
  //   );
  // }

  // static TextStyle textSize24({
  //   Color? color,
  //   FontWeight? fontWeight,
  // }) {
  //   return _baseFont(
  //     color: color ?? Colors.black,
  //     fontWeight: fontWeight ?? FontWeight.bold,
  //     fontSize: 24.0,
  //   );
  // }
}
