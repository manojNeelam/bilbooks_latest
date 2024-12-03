import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:billbooks_app/features/notifications/domain/entities/notifcation_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class NotificationItem extends StatelessWidget {
  final ActivitylogEntity activitylogEntity;
  const NotificationItem({super.key, required this.activitylogEntity});

/*
"operation_type": "update",
                "parameters": "null",
                "user_id": "0",
                "client_id": "23327",
                "item_id": "0",
                "estimate_id": "9965",
                "invoice_id": "0",
                "payment_id": "0",
                "expense_id": "0",
                "category_id": "0",
                "project_id": "0",
                "tax_id": "0",
*/
  RichText _getTrnsactionDesc() {
    var trasactionType = activitylogEntity.transactionType ?? "";
    var userId = activitylogEntity.userId ?? "";
    var clientId = activitylogEntity.clientId ?? "";
    var itemId = activitylogEntity.itemId ?? "";
    var estimateId = activitylogEntity.estimateId ?? "";
    var invoiceId = activitylogEntity.invoiceId ?? "";
    var paymentId = activitylogEntity.paymentId ?? "";
    var expenseId = activitylogEntity.expenseId ?? "";
    var categoryId = activitylogEntity.categoryId ?? "";
    var projectId = activitylogEntity.projectId ?? "";
    var taxId = activitylogEntity.taxId ?? "";
    var operationType = activitylogEntity.operationType ?? "";
    var createName = activitylogEntity.createdName ?? "";
    var parameters = activitylogEntity.parameters ?? "";

    var idVal = "";
    if (userId.isNotEmpty && userId != "0") {
      idVal = userId;
    } else if (clientId.isNotEmpty && clientId != "0") {
      idVal = clientId;
    } else if (itemId.isNotEmpty && itemId != "0") {
      idVal = itemId;
    } else if (estimateId.isNotEmpty && estimateId != "0") {
      idVal = estimateId;
    } else if (invoiceId.isNotEmpty && invoiceId != "0") {
      idVal = invoiceId;
    } else if (paymentId.isNotEmpty && paymentId != "0") {
      idVal = paymentId;
    } else if (expenseId.isNotEmpty && expenseId != "0") {
      idVal = expenseId;
    } else if (categoryId.isNotEmpty && categoryId != "0") {
      idVal = categoryId;
    } else if (expenseId.isNotEmpty && expenseId != "0") {
      idVal = expenseId;
    } else if (projectId.isNotEmpty && projectId != "0") {
      idVal = projectId;
    } else if (taxId.isNotEmpty && taxId != "0") {
      idVal = taxId;
    }

    List<TextSpan> textSpanList = [];

    if (trasactionType.isNotEmpty) {
      TextSpan transactionType = TextSpan(
          text: trasactionType.capitalize(), style: AppFonts.regularStyle());
      textSpanList.add(transactionType);
    }
    if (idVal.isNotEmpty) {
      TextSpan idValTextSpan =
          TextSpan(text: " #$idVal", style: AppFonts.regularStyle());
      textSpanList.add(idValTextSpan);
    }
    if (operationType.isNotEmpty && createName.isNotEmpty) {
      TextSpan operationTextSpan = TextSpan(
          text: " ${operationType.capitalize()}",
          style: AppFonts.regularStyle());
      TextSpan nameTextSpan = TextSpan(
          text: " ${createName.capitalize()} ",
          style: AppFonts.mediumStyle(size: 16));
      textSpanList.add(operationTextSpan);
      textSpanList.add(nameTextSpan);
    }
    if (parameters.isNotEmpty) {
      TextSpan operationTextSpan =
          TextSpan(text: "($parameters)", style: AppFonts.regularStyle());
      textSpanList.add(operationTextSpan);
    }

    return RichText(
        text: TextSpan(
            text: "", style: AppFonts.regularStyle(), children: textSpanList));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: AppConstants.verticalPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppPallete.blueColor50),
                  ),
                ),
                AppConstants.sizeBoxWidth10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTrnsactionDesc(),
                      Text(
                        (activitylogEntity.dateCreated ?? DateTime.now())
                            .getDateString(format: "HH:mm a, dd MMM yyyy"),
                        style: AppFonts.regularStyle(color: AppPallete.k666666),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const ItemSeparator(),
        ],
      ),
    );
  }
}
