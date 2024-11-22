import 'package:billbooks_app/features/invoice/domain/entities/get_document_entity.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';
import 'app_single_selection_popup.dart';
import 'item_separator.dart';

class ContactFromPopupWidget extends StatefulWidget {
  final List<ContactEntity> contacts;
  final ContactEntity? defaultContact;
  final Function(ContactEntity?) callBack;
  const ContactFromPopupWidget({
    super.key,
    required this.contacts,
    required this.defaultContact,
    required this.callBack,
  });

  @override
  State<ContactFromPopupWidget> createState() => _ContactFromPopupWidgetState();
}

class _ContactFromPopupWidgetState extends State<ContactFromPopupWidget> {
  ContactEntity? selectedContact;

  @override
  void initState() {
    selectedContact = widget.defaultContact;
    debugPrint(selectedContact?.name ?? "---");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BuildContext");
    return AppSingleSelectionPopupWidget(
        data: widget.contacts,
        defaultSelectedItem: selectedContact,
        itemBuilder: (item, seletedItem) {
          debugPrint(seletedItem?.name);
          selectedContact = seletedItem;
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
                          item.name ?? "",
                          style: AppFonts.regularStyle(
                              color: item.id == selectedContact?.id
                                  ? AppPallete.blueColor
                                  : AppPallete.textColor),
                        ),
                      ),
                      AppConstants.sizeBoxWidth10,
                      if (item.id == selectedContact?.id)
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
        title: "Contact");
  }
}
