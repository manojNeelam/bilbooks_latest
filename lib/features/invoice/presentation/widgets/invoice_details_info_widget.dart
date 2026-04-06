import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_banners/super_banners.dart';
import '../../../../core/widgets/build_if_exist_widget.dart';
import '../../domain/entities/invoice_list_entity.dart';

class InvoiceDetailsInfoWidget extends StatelessWidget {
  final EnumNewInvoiceEstimateType type;
  final InvoiceEntity invoiceEntity;
  final String estimateTitle;
  const InvoiceDetailsInfoWidget(
      {super.key,
      required this.invoiceEntity,
      required this.type,
      required this.estimateTitle});

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
                            text:
                                "${type.getName(estimateTitle: estimateTitle)} #",
                            style: AppFonts.regularStyle(size: 15),
                            children: [
                          const TextSpan(text: " "),
                          TextSpan(
                              text: invoiceEntity.no ?? "-",
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
                      color: AppPallete.k666666,
                      size: 15,
                    ),
                  ),
                  buildTextIfNotEmpty(
                    invoiceEntity.clientName,
                    style: AppFonts.mediumStyle(
                      size: 16,
                      color: AppPallete.blueColor,
                    ),
                  ),
                  buildTextIfNotEmpty(
                    invoiceEntity.clientAddress,
                    style: AppFonts.regularStyle(
                      color: AppPallete.textColor,
                      size: 15,
                    ),
                  ),
                  buildTextIfNotEmpty(
                    "${invoiceEntity.clientCity ?? ""} ${invoiceEntity.clientState ?? ""} ${invoiceEntity.clientZipcode ?? ""}"
                        .trim(),
                    style: AppFonts.regularStyle(
                      color: AppPallete.textColor,
                      size: 15,
                    ),
                  ),
                  buildTextIfNotEmpty(
                    invoiceEntity.clientCountry,
                    style: AppFonts.regularStyle(
                      color: AppPallete.textColor,
                      size: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Utils.openLink("tel:${invoiceEntity.clientPhone}");
                    },
                    child: buildTextIfNotEmpty(
                      invoiceEntity.clientPhone,
                      prefix: "Phone: ",
                      style: AppFonts.regularStyle(
                        color: AppPallete.textColor,
                        size: 15,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Utils.openLink(invoiceEntity.clientWebsite ?? ""),
                    child: buildTextIfNotEmpty(
                      invoiceEntity.clientWebsite,
                      prefix: "Website: ",
                      style: AppFonts.regularStyle(
                        color: AppPallete.textColor,
                        size: 15,
                      ),
                    ),
                  ),
                  buildTextIfNotEmpty(
                    invoiceEntity.clientTaxId,
                    style: AppFonts.regularStyle(
                      color: AppPallete.textColor,
                      size: 15,
                    ),
                  ),
                  if (invoiceEntity.summary?.isNotEmpty == true) ...[
                    AppConstants.sizeBoxHeight15,
                    RichText(
                      text: TextSpan(
                        text: "Title: ",
                        style: AppFonts.regularStyle(
                          color: AppPallete.k666666,
                          size: 15,
                        ),
                        children: [
                          TextSpan(
                            text: invoiceEntity.summary!,
                            style: AppFonts.regularStyle(
                              size: 15,
                              color: AppPallete.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (invoiceEntity.projectName?.isNotEmpty == true) ...[
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Project: ",
                        style: AppFonts.regularStyle(
                          color: AppPallete.k666666,
                          size: 15,
                        ),
                        children: [
                          TextSpan(
                            text: invoiceEntity.projectName!,
                            style: AppFonts.regularStyle(
                              size: 15,
                              color: AppPallete.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ))
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
