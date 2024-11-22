import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';

typedef ItemBuilder<T> = Widget Function(T item, List<T>? selectedItem);

class AppMultiSelectionPopupWidget<T> extends StatefulWidget {
  final List<T> data;
  final ItemBuilder<T> itemBuilder;
  final List<T>? defaultSelectedItems;
  final Function(List<T>?) selectedOk;
  final String title;

  const AppMultiSelectionPopupWidget(
      {super.key,
      required this.data,
      required this.itemBuilder,
      required this.selectedOk,
      required this.title,
      this.defaultSelectedItems});

  @override
  State<AppMultiSelectionPopupWidget<T>> createState() =>
      _AppMultiSelectionPopupWidgetState<T>();
}

class _AppMultiSelectionPopupWidgetState<T>
    extends State<AppMultiSelectionPopupWidget<T>> {
  List<T>? selectedItems;

  @override
  void initState() {
    selectedItems = widget.defaultSelectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min, // <---
        children: [
          AppConstants.sizeBoxHeight10,
          Text(
            widget.title,
            style: AppFonts.mediumStyle(),
          ),
          AppConstants.sizeBoxHeight10,
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          final item = widget.data[index];
                          if (selectedItems != null &&
                              selectedItems!.isNotEmpty &&
                              selectedItems!.contains(item)) {
                            debugPrint("Item already contained, removed it");

                            selectedItems!.remove(item);
                          } else {
                            debugPrint("Item added");
                            selectedItems!.add(item);
                          }
                        });
                      },
                      child: widget.itemBuilder(
                          widget.data[index], selectedItems));
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20)),
                      border: Border.all(color: AppPallete.itemDividerColor)),
                  child: TextButton(
                      onPressed: () {
                        AutoRouter.of(context).maybePop();
                      },
                      child: Text(
                        "Cancel",
                        style:
                            AppFonts.regularStyle(color: AppPallete.blueColor),
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20)),
                      border: Border.all(color: AppPallete.itemDividerColor)),
                  child: TextButton(
                      onPressed: () {
                        AutoRouter.of(context).maybePop();
                        widget.selectedOk(selectedItems);
                      },
                      child: Text(
                        "Ok",
                        style:
                            AppFonts.regularStyle(color: AppPallete.blueColor),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
