import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:flutter/material.dart';

import '../../features/clients/presentation/Models/client_currencies.dart';
import '../app_constants.dart';
import '../theme/app_fonts.dart';
import '../theme/app_pallete.dart';

typedef ItemBuilder<T> = Widget Function(T item, T? selectedItem);

class AppSingleSelectionPopupWidget<T> extends StatefulWidget {
  final List<T> data;
  final ItemBuilder<T> itemBuilder;
  final T? defaultSelectedItem;
  final Function(T?) selectedOk;
  final String title;

  const AppSingleSelectionPopupWidget(
      {super.key,
      required this.data,
      required this.itemBuilder,
      required this.selectedOk,
      required this.title,
      this.defaultSelectedItem});

  @override
  State<AppSingleSelectionPopupWidget<T>> createState() =>
      _AppSingleSelectionPopupWidgetState<T>();
}

class _AppSingleSelectionPopupWidgetState<T>
    extends State<AppSingleSelectionPopupWidget<T>> {
  T? selectedItem;
  List<T> items = [];

  @override
  void initState() {
    selectedItem = widget.defaultSelectedItem;
    items = widget.data;
    //checkCurrency();
    super.initState();
  }

  void checkCurrency() {
    if (T.runtimeType is CurrencyModel) {
      items = items.where((element) {
        final currentReturnedModel = element as CurrencyModel;
        return currentReturnedModel.name?.contains("ind") ?? false;
      }).toList();
    } else {
      debugPrint("T is not currenct model: ${T.toString()}");
    }
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
          AppConstants.sepSizeBox5,
          ItemSeparator(),
          AppConstants.sizeBoxHeight10,
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () async {
                        debugPrint(selectedItem.toString());
                        selectedItem = items[index];
                        setState(() {});
                        await dismissView();
                      },
                      child: widget.itemBuilder(items[index], selectedItem));
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
                        widget.selectedOk(selectedItem);
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

  Future<void> dismissView() async {
    Future.delayed(const Duration(milliseconds: 250), () {
      AutoRouter.of(context).maybePop();
      widget.selectedOk(selectedItem);
    });
  }
}
