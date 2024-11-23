import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/widgets/input_discount_view.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/input_dropdown_view.dart';
import '../../../core/widgets/new_inputview_widget.dart';
import '../../../core/widgets/new_multiline_input_widget.dart';
import '../../../core/widgets/tax_list_popup.dart';
import '../../../router/app_router.dart';
import '../../invoice/domain/entities/invoice_details_entity.dart';
import '../../item/domain/entities/item_list_entity.dart';
import '../../taxes/presentation/bloc/tax_bloc.dart';

@RoutePage()
class AddNewLineItemPage extends StatefulWidget {
  final List<TaxEntity> taxes;
  final List<ItemListEntity>? items;
  final InvoiceItemEntity? updateLineItem;
  final int? updateIndex;
  final Function(InvoiceItemEntity?, int?) enterItemModel;
  const AddNewLineItemPage(
      {super.key,
      this.items,
      required this.enterItemModel,
      required this.taxes,
      this.updateLineItem,
      this.updateIndex});

  @override
  State<AddNewLineItemPage> createState() => _AddNewLineItemPageState();
}

class _AddNewLineItemPageState extends State<AddNewLineItemPage> {
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  List<TaxEntity> taxes = [];
  List<TaxEntity>? selectedTaxes = [];
  ItemListEntity? selectedItem;
  InvoiceItemEntity? newItemModel;

  DateTime selectedLineItemDate = DateTime.now();
  bool isPercentage = true;
  @override
  void initState() {
    newItemModel = widget.updateLineItem;

    _populateData();
    //_fetchTaxes();
    _checkIfItemSelected();
    super.initState();
  }

  void _populateData() {
    taxes = widget.taxes;
    final updateItem = widget.updateLineItem;
    if (updateItem != null) {
      descController.text = updateItem.description ?? "";
      qtyController.text = (updateItem.qty ?? 0).toString();
      rateController.text = (updateItem.rate ?? 0).toString();
      //dateController.text = (updateItem.date ?? DateTime.now());
      discountController.text = (updateItem.discountValue ?? 0).toString();
      isPercentage = (updateItem.discountType ?? "") == "0" ? true : false;
      selectedTaxes = updateItem.taxes;
      selectedItem = ItemListEntity(
          id: updateItem.itemId,
          name: updateItem.itemName,
          type: updateItem.type);
      getFinalAmount();
      //setState(() {});
    } else {
      debugPrint("No Update Item");
      qtyController.text = "1";
      rateController.text = "0.00";
      discountController.text = "0.00";
    }
  }

  // void _fetchTaxes() {
  //   context.read<TaxBloc>().add(GetTaxList());
  // }

  void _openItemsPage() {
    AutoRouter.of(context).push(ItemsPopupRoute(
        itemsListFromBaseClass: widget.items,
        selectedItem: selectedItem,
        onSelectedItem: (item) {
          selectedItem = item;

          descController.text = selectedItem?.description ?? "";
          rateController.text = selectedItem?.rate ?? "";
          qtyController.text = selectedItem?.unit ?? "";
          selectedTaxes = selectedItem?.taxes;

          debugPrint("Taxes");
          debugPrint((selectedItem?.taxes?.length ?? 0).toString());

          //qtyController.text = selectedItem?.qty ?? ""

          // TextEditingController descController = TextEditingController();
          // TextEditingController dateController = TextEditingController();
          // TextEditingController qtyController = TextEditingController();
          // TextEditingController rateController = TextEditingController();
          // TextEditingController discountController = TextEditingController();

          setState(() {});
        }));
  }

  void _checkIfItemSelected() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (selectedItem == null) _openItemsPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(Icons.close)),
        title: const Text("Add Line Item"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {
                final discountType = isPercentage ? "0" : "1";

                newItemModel = InvoiceItemEntity(
                    type: selectedItem?.type,
                    itemId: selectedItem?.id ?? "",
                    itemName: selectedItem?.name ?? "",
                    description: descController.text,
                    date: DateTime.now(),
                    qty: int.parse(qtyController.text),
                    unit: selectedItem?.unit,
                    rate: rateController.text,
                    discountType: discountType,
                    discountValue: discountController.text,
                    amount: getFinalAmount(),
                    isTaxable: isTaxable(),
                    taxes: selectedTaxes);
                widget.enterItemModel(newItemModel, widget.updateIndex);
                AutoRouter.of(context).maybePop();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              AppConstants.sizeBoxHeight10,
              InputDropdownView(
                  title: "Items",
                  defaultText: "Tap to Select",
                  value: selectedItem?.name ?? "",
                  isRequired: false,
                  showDivider: true,
                  isMediumFont:
                      (selectedItem?.name ?? "").isEmpty ? false : true,
                  dropDownImageName: Icons.chevron_right,
                  onPress: () {
                    _openItemsPage();
                  }),
              NewMultilineInputWidget(
                title: "Description",
                hintText: "Add description to your item",
                controller: descController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.newline,
                isRequired: false,
                showDivider: true,
              ),
              /*InputDropdownView(
                  title: "Date",
                  defaultText: selectedLineItemDate.getDateString(),
                  value: selectedLineItemDate.getDateString(),
                  isRequired: false,
                  showDivider: true,
                  onPress: () async {
                    final date =
                        await buildMaterialDatePicker(context, DateTime.now());
                    selectedLineItemDate = date ?? DateTime.now();
                    setState(() {});
                  }),*/
              NewInputViewWidget(
                title: "Qty",
                hintText: "0",
                controller: qtyController,
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                isRequired: false,
                onChanged: (value) {
                  getFinalAmount();
                  setState(() {});
                },
              ),
              NewInputViewWidget(
                title: "Rate",
                hintText: "0.00",
                controller: rateController,
                inputType: TextInputType.number,
                inputAction: TextInputAction.next,
                isRequired: false,
                onChanged: (value) {
                  getFinalAmount();
                  setState(() {});
                },
              ),
              InputDiscountWidget(
                controller: discountController,
                callback: () {
                  isPercentage = !isPercentage;
                  getFinalAmount();
                  setState(() {});
                },
                isPercentage: isPercentage,
                showDivider: true,
                onChanged: (value) {
                  getFinalAmount();
                  setState(() {});
                },
              ),
              BlocListener<TaxBloc, TaxState>(
                listener: (context, state) {
                  if (state is TaxListSuccessState) {
                    debugPrint((state.taxListResEntity.data?.taxes?.length ?? 0)
                        .toString());
                    taxes = state.taxListResEntity.data?.taxes ?? [];
                    debugPrint("Taxes First name: ${taxes.first.name}");
                  }
                },
                child: InputDropdownView(
                    title: "Tax",
                    defaultText: "Tap to select",
                    value: _getTaxesValue(),
                    isRequired: false,
                    showDivider: false,
                    onPress: () {
                      _showTaxPopup();
                    }),
              ),
              AppConstants.sizeBoxHeight10,
              Container(
                color: AppPallete.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Line Total ",
                          style: AppFonts.mediumStyle(size: 16)),
                      TextSpan(
                          text: "(INR)",
                          style: AppFonts.regularStyle(
                              color: AppPallete.borderColor)),
                    ])),
                    Text(
                      "\$${getFinalAmount()}",
                      style: AppFonts.mediumStyle(size: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isTaxable() {
    if (selectedTaxes != null && selectedTaxes!.isNotEmpty) {
      return true;
    }
    return false;
  }

  String getFinalAmount() {
    debugPrint(qtyController.text);
    debugPrint(rateController.text);
    debugPrint(discountController.text);
    double quantity = 0;
    double rate = 0;
    double discount = 0;

    if (qtyController.text.isNotEmpty && isNumeric(qtyController.text)) {
      if (!double.parse(qtyController.text).isNaN) {
        quantity = double.parse(qtyController.text);
      }
    }
    if (rateController.text.isNotEmpty && isNumeric(rateController.text)) {
      if (!double.parse(rateController.text).isNaN) {
        rate = double.parse(rateController.text);
      }
    }
    if (discountController.text.isNotEmpty &&
        isNumeric(discountController.text)) {
      if (!double.parse(discountController.text).isNaN) {
        discount = double.parse(discountController.text);
      }
    }

    debugPrint("Quantity $quantity");
    debugPrint("Rate $rate");
    debugPrint("Discount $discount");

    final total = quantity * rate;
    final discountValue = isPercentage ? discount / 100 * total : discount;
    final finalAmt = total - discountValue;
    debugPrint(finalAmt.toString());
    return finalAmt.toStringAsFixed(2);
  }

  String _getTaxesValue() {
    if (selectedTaxes != null && selectedTaxes!.isNotEmpty) {
      final taxes = selectedTaxes?.map((item) {
        return "${item.name} (${item.rate}%)";
      });
      return taxes?.join(", ") ?? "Select taxes";
    }
    return "Select taxes";
  }

  void _showTaxPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return TaxListPopup(
              taxEnties: taxes,
              defaultTaxEntities: selectedTaxes,
              callBack: (currency) {
                selectedTaxes = currency;
                setState(() {});
              });
        });
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
