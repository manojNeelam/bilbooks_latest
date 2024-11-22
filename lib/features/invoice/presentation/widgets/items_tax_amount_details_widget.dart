import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:flutter/material.dart';

import '../add_new_invoice_page.dart';

class ItemsTaxAmountDetailsWidget extends StatelessWidget {
  final InvoiceDetailResEntity invoiceDetailResEntity;
  final InvoiceEntity invoiceEntity;
  final bool isInvoice;
  const ItemsTaxAmountDetailsWidget({
    super.key,
    required this.invoiceDetailResEntity,
    required this.invoiceEntity,
    required this.isInvoice,
  });

  @override
  Widget build(BuildContext context) {
    List<ItemTaxInfo> calculateListOfTaxes() {
      List<ItemTaxInfo> taxList = [];
      if (invoiceEntity.items != null && invoiceEntity.items!.isNotEmpty) {
        for (final item in invoiceEntity.items!) {
          final amount = item.amount ?? "0";
          final amountAsDouble = double.parse(amount);

          if (item.taxes != null && item.taxes!.isNotEmpty) {
            for (final tax in item.taxes!) {
              final rate = tax.rate ?? 0;
              final taxValue = (rate / 100) * amountAsDouble;

              final index = taxList.indexWhere((returnedItem) {
                return returnedItem.id == tax.id;
              });
              if (index >= 0) {
                final amount = taxList[index].amount; //10
                final appendAmount = taxValue + amount; //5 + 10 = 15
                taxList[index] = ItemTaxInfo(
                  id: tax.id ?? "",
                  amount: appendAmount,
                  name: tax.name ?? "",
                  rate: tax.rate.toString(),
                );
              } else {
                taxList.add(ItemTaxInfo(
                  id: tax.id ?? "", //1
                  amount: taxValue, //10
                  name: tax.name ?? "", //GST
                  rate: tax.rate.toString(), //10
                ));
              }
            }
          }
        }
      }
      return taxList;
    }

    List<ItemTaxInfo> selectedItemTaxesList = calculateListOfTaxes();

    bool canShowPaidBalance() {
      final status = invoiceEntity.status ?? "";
      if (isInvoice && status.isNotEmpty && status.toLowerCase() != "draft") {
        return true;
      }
      return false;
    }

    (bool, String) canShowShipping() {
      final shipping = invoiceEntity.shipping ?? "";
      if (shipping.isNotEmpty) {
        final appendCurrency = "\$$shipping";
        return (true, appendCurrency);
      }
      return (false, "");
    }

    (bool, String, String) canShowDiscount() {
      final discount = invoiceEntity.discount ?? "";
      final discountType = invoiceEntity.discountType ?? "";
      final discountValue = invoiceEntity.discountValue ?? "";
      if (discount.isNotEmpty) {
        final appendCurrency = "\$$discount";
        if (discountType == "0") {
          return (true, appendCurrency, "$discountValue%");
        }
        return (true, appendCurrency, "");
      }
      return (false, "", "");
    }

    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      padding: AppConstants.horizontalVerticalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              getTaxCell(context,
                  title: "Subtotal",
                  subTitle: "",
                  value: "\$${invoiceEntity.subtotal ?? "-"}",
                  isSubTotal: true),
              AppConstants.sepSizeBox5,
              if (canShowDiscount().$1)
                Column(
                  children: [
                    getTaxCell(context,
                        title: canShowDiscount().$3.isNotEmpty
                            ? "Discount (${canShowDiscount().$3})"
                            : "Discount",
                        subTitle: "",
                        value: canShowDiscount().$2,
                        isSubTotal: false),
                    AppConstants.sepSizeBox5,
                  ],
                ),
              for (var taxItem in selectedItemTaxesList)
                getTaxCell(context,
                    title: "${taxItem.name} (${taxItem.rate}%)",
                    subTitle: "",
                    value: "\$${taxItem.amount.toStringAsFixed(2)}",
                    isSubTotal: false),
              AppConstants.sepSizeBox5,
              if (canShowShipping().$1 == true)
                Column(
                  children: [
                    getTaxCell(
                      context,
                      title: "Shipping",
                      subTitle: "",
                      value: canShowShipping().$2,
                    ),
                    AppConstants.sepSizeBox5,
                  ],
                ),
              getTaxCell(context,
                  title: "Total",
                  subTitle: "(AUD)",
                  value: "\$${invoiceEntity.nettotal ?? "-"}",
                  isTotal: true),
              if (canShowPaidBalance())
                Column(
                  children: [
                    AppConstants.sepSizeBox5,
                    getTaxCell(context,
                        title: "Paid",
                        subTitle: "",
                        value: "\$${invoiceEntity.paid ?? "0.00"}",
                        isPaid: true),
                    AppConstants.sepSizeBox5,
                    getTaxCell(context,
                        title: "Amount Due",
                        subTitle: "",
                        value: "\$${invoiceEntity.balance ?? "0.00"}",
                        isDue: true),
                  ],
                )
            ],
          ),
          AppConstants.sizeBoxHeight15,
          Text(
            "Notes:",
            style: AppFonts.regularStyle(color: AppPallete.k666666),
          ),
          Text(
            invoiceEntity.notes ?? "-",
            style: AppFonts.regularStyle(),
          )
        ],
      ),
    );
  }

  Widget getTaxCell(
    BuildContext context, {
    required String title,
    required String subTitle,
    required String value,
    bool isTotal = false,
    bool isSubTotal = false,
    bool isPaid = false,
    bool isDue = false,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: isSubTotal || isPaid || isDue
              ? Text(
                  title,
                  textAlign: TextAlign.end,
                  style: AppFonts.mediumStyle(
                      size: 16,
                      color: isPaid
                          ? AppPallete.greenColor
                          : isDue
                              ? AppPallete.red
                              : AppPallete.textColor),
                )
              : RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                      text: title,
                      style: isTotal
                          ? AppFonts.mediumStyle(
                              size: 16, color: AppPallete.blueColor)
                          : AppFonts.regularStyle(),
                      children: [
                        const TextSpan(text: " "),
                        TextSpan(
                            text: subTitle,
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666))
                      ])),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: isSubTotal
                ? AppFonts.mediumStyle(size: 16)
                : AppFonts.mediumStyle(
                    size: 16,
                    color: isPaid
                        ? AppPallete.greenColor
                        : isDue
                            ? AppPallete.red
                            : isTotal
                                ? AppPallete.blueColor
                                : AppPallete.textColor,
                  ),
          ),
        )
      ],
    );
  }
}
