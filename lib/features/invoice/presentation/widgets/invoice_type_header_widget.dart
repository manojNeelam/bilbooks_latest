import 'package:billbooks_app/features/invoice/presentation/invoice_list_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class InvoiceTypeHeaderWidget extends StatelessWidget {
  final EnumInvoiceType selectedType;
  final Function(EnumInvoiceType) callBack;
  const InvoiceTypeHeaderWidget(
      {super.key, required this.selectedType, required this.callBack});

  @override
  Widget build(BuildContext context) {
    const EnumInvoiceType all = EnumInvoiceType.all;
    const EnumInvoiceType draft = EnumInvoiceType.draft;
    const EnumInvoiceType unpaid = EnumInvoiceType.unpaid;
    const EnumInvoiceType paid = EnumInvoiceType.paid;

    Color getColorFor(EnumInvoiceType type) {
      return type == selectedType ? AppPallete.blueColor : AppPallete.clear;
    }

    TextStyle getStyleFor(EnumInvoiceType type) {
      return type == selectedType
          ? AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16)
          : AppFonts.regularStyle(color: AppPallete.textColor, size: 16);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(all);
                        },
                        child: Text(
                          all.title,
                          style: getStyleFor(all),
                        )),
                    Container(
                      height: 2,
                      color: getColorFor(all),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        callBack(draft);
                      },
                      child: Text(draft.title, style: getStyleFor(draft)),
                    ),
                    Container(
                      height: 2,
                      color: getColorFor(draft),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(unpaid);
                        },
                        child: Text(unpaid.title, style: getStyleFor(unpaid))),
                    Container(
                      height: 2,
                      color: getColorFor(unpaid),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(paid);
                        },
                        child: Text(
                          paid.title,
                          style: getStyleFor(paid),
                        )),
                    Container(
                      height: 2,
                      color: getColorFor(paid),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const ItemSeparator()
      ],
    );
  }
}
