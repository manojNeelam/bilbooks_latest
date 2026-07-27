import 'package:billbooks_app/features/proforma/presentation/add_proforma_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';

class ProformaInfoWidget extends StatelessWidget {
  final Color? invoiceStatusColor;
  final ProformaRequestModel proformaRequestModel;
  const ProformaInfoWidget(
      {super.key, this.invoiceStatusColor, required this.proformaRequestModel});

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
                        text: proformaRequestModel.title,
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
                  (proformaRequestModel.date ?? DateTime.now()).getDateString(),
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
        ],
      ),
    );
  }

  bool isValidTitle() {
    if (proformaRequestModel.title != null &&
        proformaRequestModel.title!.isNotEmpty) {
      return true;
    }
    return false;
  }

  String? getTitle() {
    if (isValidTitle()) {
      return proformaRequestModel.title;
    }
    return null;
  }

  String? getExpiryDate() {
    if (proformaRequestModel.expiryDate == null) {
      return null;
    }
    return proformaRequestModel.expiryDate!.getDateString();
  }

  bool isValidInvoiceNumber() {
    if (proformaRequestModel.no != null &&
        proformaRequestModel.no!.isNotEmpty) {
      return true;
    }
    return false;
  }

  String? getInvoiceNumber() {
    if (isValidInvoiceNumber()) {
      return "#${proformaRequestModel.no}";
    }
    return null;
  }
}
