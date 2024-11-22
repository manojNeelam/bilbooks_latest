import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ItemSeparator extends StatelessWidget {
  const ItemSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.5,
      thickness: 0.5,
      color: AppPallete.itemDividerColor,
    );
  }
}
