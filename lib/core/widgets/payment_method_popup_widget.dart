import 'package:billbooks_app/features/invoice/domain/entities/payment_method_entity.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class PaymentMethodPopupWidget extends StatefulWidget {
  final List<PaymentMethodEntity> paymentMethods;
  final PaymentMethodEntity? defaultpaymentReminder;
  final Function(PaymentMethodEntity?) callBack;
  const PaymentMethodPopupWidget({
    super.key,
    required this.callBack,
    required this.defaultpaymentReminder,
    required this.paymentMethods,
  });

  @override
  State<PaymentMethodPopupWidget> createState() =>
      _PaymentMethodPopupWidgetState();
}

class _PaymentMethodPopupWidgetState extends State<PaymentMethodPopupWidget> {
  PaymentMethodEntity? selectedPaymentMethod;

  @override
  void initState() {
    selectedPaymentMethod = widget.defaultpaymentReminder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.paymentMethods,
        defaultSelectedItem: selectedPaymentMethod,
        itemBuilder: (item, seletedItem) {
          selectedPaymentMethod = seletedItem;
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
                          item.name ?? "",
                          style: AppFonts.regularStyle(
                              color: item.methodId ==
                                      selectedPaymentMethod?.methodId
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.methodId == selectedPaymentMethod?.methodId)
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
        title: "Payment Methods");
  }
}
