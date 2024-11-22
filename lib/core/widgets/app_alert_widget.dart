import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';

enum EnumAppAlertType { delete, ok, voidInvoice, unVoid }

extension EnumAppAlertTypeExtension on EnumAppAlertType {
  String get title {
    switch (this) {
      case EnumAppAlertType.delete:
        return "Delete";
      case EnumAppAlertType.ok:
        return "Ok";
      case EnumAppAlertType.voidInvoice:
        return "Void it";
      case EnumAppAlertType.unVoid:
        return "Unvoid it";
    }
  }
}

class AppAlertWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onTapDelete;
  final EnumAppAlertType alertType;
  const AppAlertWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.onTapDelete,
      this.alertType = EnumAppAlertType.delete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min, // <---
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: AppFonts.mediumStyle(size: 18),
          ),
          AppConstants.sepSizeBox5,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppFonts.regularStyle(size: 14),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20)),
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: AppPallete.itemDividerColor, width: 1),
                          vertical: BorderSide(
                              color: AppPallete.itemDividerColor, width: 0.5))),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                      child: Text(
                        "Cancel",
                        style: AppFonts.mediumStyle(
                            color: AppPallete.blueColor, size: 16),
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20)),
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: AppPallete.itemDividerColor, width: 1),
                          vertical: BorderSide(
                              color: AppPallete.itemDividerColor, width: 0.5))),
                  child: TextButton(
                      onPressed: onTapDelete,
                      child: Text(
                        alertType.title,
                        style: AppFonts.mediumStyle(
                            color: alertType == EnumAppAlertType.ok
                                ? AppPallete.blueColor
                                : AppPallete.red,
                            size: 16),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
