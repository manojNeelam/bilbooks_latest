// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class AuthField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  TextInputType inputType;
  TextInputAction inputAction;
  final Function(String) onChanged;
  Widget prefixIcon;

  AuthField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.inputType,
    required this.inputAction,
    required this.prefixIcon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      style: AppFonts.regularStyle(),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true, // Reduces height a bit
        fillColor: AppPallete.white,
        filled: true,
        enabledBorder: border(),
        focusedBorder: border(AppPallete.blueColor),
      ),
    );
  }
}

border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    );
