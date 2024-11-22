import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_terms_model.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
//  List<PaymentTerms>? items;

class PaymentTermsPopupWidget extends StatefulWidget {
  final List<PaymentTerms> paymentTerms;
  final PaymentTerms? defaultPaymentTerms;
  final Function(PaymentTerms?) callBack;
  const PaymentTermsPopupWidget(
      {super.key,
      required this.paymentTerms,
      this.defaultPaymentTerms,
      required this.callBack});

  @override
  State<PaymentTermsPopupWidget> createState() =>
      _PaymentTermsPopupWidgetState();
}

class _PaymentTermsPopupWidgetState extends State<PaymentTermsPopupWidget> {
  PaymentTerms? selectedPaymentTerms;

  @override
  void initState() {
    selectedPaymentTerms = widget.defaultPaymentTerms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.paymentTerms,
        defaultSelectedItem: selectedPaymentTerms,
        itemBuilder: (item, seletedItem) {
          selectedPaymentTerms = seletedItem;
          return Container(
            padding: AppConstants.horizotal16,
            child: Column(
              children: [
                Padding(
                  padding: AppConstants.verticalPadding10,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.label ?? "",
                          style: AppFonts.regularStyle(
                              color: item.value == selectedPaymentTerms?.value
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.value == selectedPaymentTerms?.value)
                        const Icon(
                          Icons.check,
                          color: AppPallete.blueColor,
                        )
                    ],
                  ),
                ),
                const ItemSeparator()
              ],
            ),
          );
        },
        selectedOk: (country) {
          widget.callBack(country);
        },
        title: "Payment Terms");
  }
}
