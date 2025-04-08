import 'package:flutter/material.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/cap_status_widget.dart';
import '../../../../core/widgets/item_separator.dart';
import '../../../invoice/domain/entities/invoice_list_entity.dart';

class EstimateListItemWidget extends StatelessWidget {
  final InvoiceEntity estimateEntity;
  const EstimateListItemWidget({super.key, required this.estimateEntity});

  Widget getLeftSideBottomWidget() {
    if (dueDays().isNotEmpty) {
      return CapsuleStatusWidget(
          title: dueDays(),
          backgroundColor: AppPallete.kF2F2F2,
          textColor: AppPallete.k666666);
    }

    return SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        estimateEntity.clientName ?? "",
                        style: AppFonts.regularStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppConstants.sepSizeBox5,
                      Text(
                        "#${estimateEntity.no ?? "-"}",
                        style: AppFonts.regularStyle(
                            size: 15, color: AppPallete.k666666),
                        maxLines: 1,
                      ),
                      AppConstants.sepSizeBox5,
                      getLeftSideBottomWidget(),
                    ],
                  ),
                ),
                AppConstants.sizeBoxWidth15,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${estimateEntity.nettotal ?? ""}",
                      style: AppFonts.mediumStyle(size: 16),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      getFormattedDate(),
                      style: AppFonts.regularStyle(
                          size: 15, color: AppPallete.k666666),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      "${estimateEntity.status}".toUpperCase(),
                      style:
                          AppFonts.regularStyle(size: 13, color: statusColor()),
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

  String dueDays() {
    final days = estimateEntity.overdueDays ?? "";
    if (days.isEmpty) {
      return "";
    }
    return "Due $days days ago";
  }

  Color statusColor() {
    final status = estimateEntity.status ?? "";
    if (status.toLowerCase() == "draft") {
      return AppPallete.k666666;
    } else if (status.toLowerCase() == "paid" ||
        status.toLowerCase() == "invoiced") {
      return AppPallete.greenColor;
    } else if (status.toLowerCase() == "overdue" ||
        status.toLowerCase() == "expired") {
      return AppPallete.red;
    } else if (status.toLowerCase() == "sent") {
      return AppPallete.orangeColor;
    }
    return AppPallete.borderColor;
  }

  String getFormattedDate() {
    final estimateDate = estimateEntity.dateYmd ?? DateTime.now();
    return estimateDate.getDateString();
  }
}
