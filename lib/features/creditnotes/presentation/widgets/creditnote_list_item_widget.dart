import 'package:billbooks_app/features/creditnotes/domain/entity/credit_notes_list_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/cap_status_widget.dart';
import '../../../../core/widgets/item_separator.dart';

class CreditnoteListItemWidget extends StatelessWidget {
  final CreditNoteEntity creditNoteEntity;
  const CreditnoteListItemWidget({super.key, required this.creditNoteEntity});

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creditNoteEntity.clientName ?? "",
                      style: AppFonts.regularStyle(),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      creditNoteEntity.projectName ?? "",
                      style: AppFonts.regularStyle(
                          size: 15, color: AppPallete.k666666),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Row(
                      children: [
                        CapsuleStatusWidget(
                            title: "#${creditNoteEntity.creditnoteNo ?? "-"}",
                            backgroundColor: AppPallete.kF2F2F2,
                            textColor: AppPallete.k666666),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${creditNoteEntity.currency ?? "0.00"}",
                      style: AppFonts.mediumStyle(size: 16),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      creditNoteEntity.creditnoteDate ?? "",
                      style: AppFonts.regularStyle(
                          size: 15, color: AppPallete.k666666),
                      maxLines: 1,
                    ),
                    AppConstants.sepSizeBox5,
                    Text(
                      (creditNoteEntity.status ?? "").toUpperCase(),
                      style: AppFonts.regularStyle(size: 13),
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
}
