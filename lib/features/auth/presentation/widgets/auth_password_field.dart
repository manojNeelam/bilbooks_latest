import 'package:flutter/material.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import 'auth_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hint;
  const PasswordField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hint,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscured,
      focusNode: textFieldFocusNode,
      style: AppFonts.regularStyle(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        floatingLabelBehavior:
            FloatingLabelBehavior.never, //Hides label on focus or if filled
        hintText: widget.hint,
        filled: true, // Needed for adding a fill color
        fillColor: AppPallete.white,
        isDense: true, // Reduces height a bit
        enabledBorder: border(),
        focusedBorder: border(AppPallete.blueColor),
        prefixIcon: const Icon(
          Icons.lock,
          color: AppPallete.borderColor,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: GestureDetector(
            onTap: _toggleObscured,
            child: Icon(
              _obscured
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
