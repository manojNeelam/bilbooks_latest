import 'package:flutter/material.dart';

Widget buildTextIfNotEmpty(String? value, {String? prefix, TextStyle? style}) {
  if (value == null || value.trim().isEmpty) {
    return const SizedBox.shrink();
  }

  return Text(
    prefix != null ? "$prefix$value" : value,
    style: style,
  );
}
