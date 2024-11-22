import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:flutter/material.dart';

class InvoiceListItemWidget extends StatelessWidget {
  final InvoiceEntity invoiceEntity;
  const InvoiceListItemWidget({super.key, required this.invoiceEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      style: AppFonts.regularStyle(),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      getNo(),
                      style: AppFonts.regularStyle(
                          size: 15, color: AppPallete.k666666),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    if (isRecurring())
                      Text(
                        "Active",
                        style:
                            AppFonts.regularStyle(color: AppPallete.greenColor),
                      ),
                    if (invoiceEntity.dueDaysDisplayText.isNotEmpty)
                      CapsuleStatusWidget(
                          title: invoiceEntity.dueDaysDisplayText,
                          backgroundColor: AppPallete.kF2F2F2,
                          textColor: AppPallete.k666666)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${invoiceEntity.nettotal ?? "0.00"}",
                      style: AppFonts.mediumStyle(size: 16),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      date,
                      style: AppFonts.regularStyle(
                          size: 15, color: AppPallete.k666666),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      "${invoiceEntity.status}".toUpperCase(),
                      style: AppFonts.regularStyle(
                          size: 13, color: invoiceEntity.invoiceStatusColor),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ItemSeparator()
        ],
      ),
    );
  }

  String getNo() {
    if (isRecurring()) {
      final freqName = invoiceEntity.frequencyName ?? "";
      final remaining = invoiceEntity.howmany ?? "";
      String remainingDisplay = "";
      if (remaining == "0") {
        remainingDisplay = "Infinite";
      } else {
        remainingDisplay = "(remaining $remaining)";
      }
      return "$freqName $remainingDisplay";
    }

    final no = invoiceEntity.no ?? "-";
    return "\$$no";
  }

  bool isRecurring() {
    final status = invoiceEntity.status ?? "";
    debugPrint(status);
    if (status.toLowerCase() == "recurring") {
      return true;
    }
    return false;
  }

  String get clientName {
    final name = invoiceEntity.clientName ?? "";
    if (name.isNotEmpty) {
      return name.capitalize();
    }
    return name;
  }

  String get date {
    final date = invoiceEntity.dateYmd;
    if (date != null) {
      return date.getDateString();
    }
    return "";
  }
}
