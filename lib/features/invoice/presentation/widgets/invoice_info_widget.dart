import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:flutter/material.dart';

class InvoiceInfoWidget extends StatelessWidget {
  final EnumNewInvoiceEstimateType type;
  final InvoiceRequestModel invoiceRequestModel;
  final Color? invoiceStatusColor;
  final String estimateTitle;
  const InvoiceInfoWidget(
      {super.key,
      required this.estimateTitle,
      required this.invoiceRequestModel,
      required this.type,
      this.invoiceStatusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: type.getName(estimateTitle: estimateTitle),
                        style: AppFonts.regularStyle(),
                        children: [
                      const TextSpan(text: " "),
                      TextSpan(
                          text: getInvoiceNumber(),
                          style: AppFonts.mediumStyle(
                              color: AppPallete.blueColor, size: 16))
                    ])),
                AppConstants.sepSizeBox5,
                Text(
                  (invoiceRequestModel.date ?? DateTime.now()).getDateString(),
                  style: AppFonts.mediumStyle(size: 16),
                ),
                AppConstants.sepSizeBox5,
                Text(
                  getTitle() ?? "Title/Summary",
                  style: AppFonts.regularStyle(
                      color: isValidTitle() == false
                          ? AppPallete.k666666
                          : AppPallete.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        getPONumber() ?? "P.O. Number",
                        style: AppFonts.regularStyle(
                            color: isValidPoNumber() == false
                                ? AppPallete.k666666
                                : AppPallete.textColor),
                      ),
                      AppConstants.sepSizeBox5,
                      Text(
                        isInvoice()
                            ? getTerms() ?? "Terms 0 Days"
                            : getExpiryDate() ?? "Expiry",
                        style: AppFonts.regularStyle(
                            color: !isValidTerms()
                                ? AppPallete.k666666
                                : AppPallete.textColor),
                      ),
                      AppConstants.sepSizeBox5,
                      Text(
                        (invoiceRequestModel.status ?? "DRAFT").toUpperCase(),
                        style: AppFonts.regularStyle(
                            color: invoiceRequestModel.status == null
                                ? AppPallete.k666666
                                : invoiceStatusColor),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.chevron_right,
                        color: AppPallete.borderColor,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isInvoice() {
    if (type == EnumNewInvoiceEstimateType.duplicateInvoice ||
        type == EnumNewInvoiceEstimateType.invoice ||
        type == EnumNewInvoiceEstimateType.editInvoice ||
        type == EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
      return true;
    }
    return false;
  }

  bool isValidPoNumber() {
    if (invoiceRequestModel.poNumber != null &&
        invoiceRequestModel.poNumber!.isNotEmpty) {
      return true;
    }
    return false;
  }

  String? getPONumber() {
    if (isValidPoNumber()) {
      return invoiceRequestModel.poNumber ?? "";
    }
    return null;
  }

  bool isValidTitle() {
    if (invoiceRequestModel.title != null &&
        invoiceRequestModel.title!.isNotEmpty) {
      return true;
    }
    return false;
  }

  String? getTitle() {
    if (isValidTitle()) {
      return invoiceRequestModel.title;
    }
    return null;
  }

  bool isValidTerms() {
    switch (type) {
      case EnumNewInvoiceEstimateType.invoice ||
            EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
            EnumNewInvoiceEstimateType.duplicateInvoice:
        if (invoiceRequestModel.selectedPaymentTerms != null) {
          return true;
        }
      case EnumNewInvoiceEstimateType.estimate ||
            EnumNewInvoiceEstimateType.duplicateEstimate:
        if (invoiceRequestModel.expiryDate != null) {
          return true;
        }
      case EnumNewInvoiceEstimateType.editInvoice:
        return true;
      case EnumNewInvoiceEstimateType.editEstimate:
        return false;
    }

    return false;
  }

  String? getExpiryDate() {
    if (invoiceRequestModel.expiryDate == null) {
      return null;
    }
    return invoiceRequestModel.expiryDate!.getDateString();
  }

  String? getTerms() {
    if (isValidTerms()) {
      final payTerms = invoiceRequestModel.selectedPaymentTerms?.label ?? "";
      if (payTerms.isNotEmpty && payTerms.toLowerCase() == "due on receipt") {
        return payTerms;
      } else {
        return "Terms $payTerms";
      }
    }
    return null;
  }

  bool isValidInvoiceNumber() {
    if (invoiceRequestModel.no != null && invoiceRequestModel.no!.isNotEmpty) {
      return true;
    }
    return false;
  }

  String? getInvoiceNumber() {
    if (isValidInvoiceNumber()) {
      return "#${invoiceRequestModel.no}";
    }
    return null;
  }
}
