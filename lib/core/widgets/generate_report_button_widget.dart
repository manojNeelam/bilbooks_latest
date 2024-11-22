// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenerateReportButtonWidget extends StatelessWidget {
  final String title;
  final void Function() onpressed;
  const GenerateReportButtonWidget({
    Key? key,
    required this.title,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppPallete.white,
      child: TextButton(
          onPressed: onpressed,
          child: Text(
            title,
            style: AppFonts.regularStyle(color: AppPallete.blueColor),
          )),
    );
  }
}
