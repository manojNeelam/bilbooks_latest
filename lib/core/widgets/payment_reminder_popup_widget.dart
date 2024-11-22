import 'package:billbooks_app/features/invoice/domain/entities/payment_reminder_model.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class PaymentReminderPopupWidget extends StatefulWidget {
  final List<PaymentReminder> paymentReminders;
  final PaymentReminder? defaultpaymentReminder;
  final Function(PaymentReminder?) callBack;
  const PaymentReminderPopupWidget(
      {super.key,
      required this.paymentReminders,
      this.defaultpaymentReminder,
      required this.callBack});

  @override
  State<PaymentReminderPopupWidget> createState() =>
      _PaymentReminderPopupWidgetState();
}

class _PaymentReminderPopupWidgetState
    extends State<PaymentReminderPopupWidget> {
  PaymentReminder? selectedPaymentTerms;

  @override
  void initState() {
    selectedPaymentTerms = widget.defaultpaymentReminder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSingleSelectionPopupWidget(
        data: widget.paymentReminders,
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
        title: "Payment Reminders");
  }
}
