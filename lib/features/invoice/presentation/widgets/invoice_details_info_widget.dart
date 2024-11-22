import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_banners/super_banners.dart';
import '../../domain/entities/invoice_list_entity.dart';

class InvoiceDetailsInfoWidget extends StatelessWidget {
  final EnumNewInvoiceEstimateType type;
  final InvoiceEntity invoiceEntity;
  const InvoiceDetailsInfoWidget(
      {super.key, required this.invoiceEntity, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CornerBanner(
                bannerPosition: CornerBannerPosition.topLeft,
                bannerColor: invoiceEntity.invoiceStatusColor,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: 80,
                    child: Center(
                        child: Text(
                      (invoiceEntity.status ?? "").toUpperCase(),
                      style: AppFonts.mediumStyle(
                          color: AppPallete.white, size: 12),
                    ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: type.getName(),
                            style: AppFonts.regularStyle(size: 15),
                            children: [
                          const TextSpan(text: " "),
                          TextSpan(
                              text: "#${invoiceEntity.no ?? "-"}",
                              style: AppFonts.regularStyle(
                                  color: AppPallete.blueColor, size: 15))
                        ])),
                    AppConstants.sepSizeBox5,
                    Text(
                      convertDate(),
                      style: AppFonts.mediumStyle(size: 15),
                    ),
                    AppConstants.sepSizeBox5,
                    if (invoiceEntity.expiryDate != null &&
                        (invoiceEntity.expiryDate ?? "").isNotEmpty)
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: AppPallete.textColor,
                            size: 15,
                          ),
                          AppConstants.sizeBoxWidth5,
                          Text(
                            stringToDate(invoiceEntity.expiryDate),
                            style: AppFonts.regularStyle(
                                size: 15, color: AppPallete.textColor),
                          )
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
          AppConstants.sizeBoxHeight10,
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bill To",
                  style: AppFonts.regularStyle(
                      color: AppPallete.k666666, size: 15),
                ),
                Text(
                  "${invoiceEntity.clientName}",
                  style: AppFonts.mediumStyle(
                      size: 16, color: AppPallete.blueColor),
                ),
                Text(
                  "${invoiceEntity.clientAddress}",
                  style: AppFonts.regularStyle(
                      color: AppPallete.textColor, size: 15),
                ),
                if (invoiceEntity.summary != null) AppConstants.sizeBoxHeight15,
                if (invoiceEntity.summary != null)
                  RichText(
                      text: TextSpan(
                          text: "Title: ",
                          style: AppFonts.regularStyle(
                              color: AppPallete.k666666, size: 15),
                          children: [
                        TextSpan(
                            text: "${invoiceEntity.summary}",
                            style: AppFonts.regularStyle(
                                size: 15, color: AppPallete.textColor))
                      ])),
                if (invoiceEntity.projectName != null)
                  RichText(
                      text: TextSpan(
                          text: "Project: ",
                          style: AppFonts.regularStyle(
                              color: AppPallete.k666666, size: 15),
                          children: [
                        TextSpan(
                            text: "${invoiceEntity.projectName}",
                            style: AppFonts.regularStyle(
                                size: 15, color: AppPallete.textColor))
                      ]))
              ],
            ),
          )
        ],
      ),
    );
  }

  String convertDate() {
    final date = invoiceEntity.dateYmd ?? DateTime.now();
    return DateFormat('dd MMM yyyy').format(date);
  }

  String stringToDate(String? dateString) {
    if (dateString == null && dateString!.isEmpty) {
      return "";
    }
    try {
      final date = DateFormat('dd.MM.yyyy').parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      debugPrint(e.toString());
    }
    return dateString;
  }
}
