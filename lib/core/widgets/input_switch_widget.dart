import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:flutter/cupertino.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';

class InPutSwitchWidget extends StatelessWidget {
  const InPutSwitchWidget(
      {super.key,
      required this.title,
      required this.context,
      required this.isRecurringOn,
      required this.onChanged,
      required this.showDivider});

  final BuildContext context;
  final bool isRecurringOn;
  final bool showDivider;
  final String title;
  final Function(bool p1)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppFonts.regularStyle(),
                  ),
                ),
                CupertinoSwitch(
                  value: isRecurringOn,
                  onChanged: onChanged,
                  activeColor: AppPallete.blueColor,
                ),
              ],
            ),
          ),
          if (showDivider) const ItemSeparator()
        ],
      ),
    );
  }
}
