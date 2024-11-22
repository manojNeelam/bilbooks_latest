import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class NotesWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const NotesWidget(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.white,
      padding: AppConstants.horizontalVerticalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.regularStyle(size: 14),
          ),
          TextFormField(
            controller: controller,
            style: AppFonts.regularStyle(),
            minLines: 2,
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
                hintStyle:
                    AppFonts.regularStyle(size: 14, color: AppPallete.k666666),
                hintText: hintText,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none),
          )
        ],
      ),
    );
  }
}
