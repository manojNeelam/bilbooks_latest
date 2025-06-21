import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/input_switch_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/tax_list_popup.dart';
import 'package:billbooks_app/features/item/domain/entities/item_list_entity.dart';
import 'package:billbooks_app/features/item/domain/usecase/item_usecase.dart';
import 'package:billbooks_app/features/item/presentation/bloc/item_bloc.dart';
import 'package:billbooks_app/features/taxes/presentation/bloc/tax_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/input_dropdown_view.dart';
import '../../../core/widgets/new_multiline_input_widget.dart';
import '../../invoice/domain/entities/invoice_details_entity.dart';

@RoutePage()
class NewItemPage extends StatefulWidget {
  final bool isFromDuplicate;
  final ItemListEntity? itemListEntity;
  final Function()? refreshPage;
  final Function() popBack;
  const NewItemPage({
    super.key,
    this.itemListEntity,
    this.refreshPage,
    required this.isFromDuplicate,
    required this.popBack,
  });

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController currentStockController = TextEditingController();

  bool isSeletedRadio1 = true;
  bool trackInventory = false;
  List<TaxEntity> taxes = [];
  List<TaxEntity>? selectedTaxes = [];
  bool isFormValid = false;

  void reRenderUI() {
    setState(() {});
  }

  @override
  void initState() {
    _fetchTaxes();
    _populateData();
    super.initState();
  }

  void _fetchTaxes() {
    context.read<TaxBloc>().add(GetTaxList());
  }

  void _populateData() {
    if (widget.itemListEntity != null) {
      ItemListEntity itemListEntity = widget.itemListEntity!;
      if (itemListEntity.type != null &&
          itemListEntity.type?.toLowerCase() == "service".toLowerCase()) {
        isSeletedRadio1 = true;
      } else {
        isSeletedRadio1 = false;
        trackInventory = true;
      }
      itemNameController.text = itemListEntity.name ?? "";
      skuController.text = itemListEntity.sku ?? "";
      descController.text = itemListEntity.description ?? "";
      rateController.text = itemListEntity.rate ?? "";
      unitController.text = itemListEntity.unit ?? "";
      currentStockController.text = "${itemListEntity.stock ?? 0}";
      selectedTaxes = itemListEntity.taxes;
      debugPrint("Taxes Length: ${itemListEntity.taxes?.length.toString()}");
      _validateItemForm();
    }
  }

  void showTaxPopup() {
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

  void _validateItemForm() {
    if (itemNameController.text.isNotEmpty != isFormValid) {
      isFormValid = itemNameController.text.isNotEmpty;
      setState(() {});
    }
  }

  String getTaxesValue() {
    if (selectedTaxes != null && selectedTaxes!.isNotEmpty) {
      final taxes = selectedTaxes?.map((item) {
        return "${item.name} (${item.rate}%)";
      });
      return taxes?.join(", ") ?? "Select taxes";
    }
    return "Select taxes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPallete.kF2F2F2,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                widget.popBack();
                AutoRouter.of(context).maybePop();
              },
              icon: const Icon(Icons.close)),
          title: Text(isEdit ? "Edit Item" : "New Item"),
          actions: [
            TextButton(
                onPressed: isFormValid
                    ? () {
                        final itemModel = getAddItemReqModel();
                        context
                            .read<ItemBloc>()
                            .add(AddItemEvent(addIemReqModel: itemModel));
                      }
                    : null,
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(
                      color: isFormValid
                          ? AppPallete.blueColor
                          : AppPallete.blueColor.withOpacity(0.3)),
                ))
          ],
        ),
        body: BlocConsumer<ItemBloc, ItemState>(
          listener: (context, state) {
            if (state is ErrorDeleteItemState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            } else if (state is SuccessDeleteItemState) {
              showToastification(context, "Successfully item deleted",
                  ToastificationType.success);

              if (widget.refreshPage != null) {
                widget.refreshPage!();
              } else {
                widget.popBack();
              }
              AutoRouter.of(context).maybePop();
            } else if (state is SuccessAddItemState) {
              var msg = isEdit ? "updated" : "added";
              showToastification(context, "Successfully item $msg",
                  ToastificationType.success);
              if (widget.refreshPage != null) {
                widget.refreshPage!();
              } else {
                widget.popBack();
              }
              AutoRouter.of(context).maybePop();
            }
          },
          builder: (context, state) {
            if (state is AddItemLoadingState) {
              return LoadingPage(
                  title: isEdit ? "Updating item.." : "Adding item..");
            }

            if (state is DeleteItemLoadingState) {
              return const LoadingPage(title: "Deleting item..");
            }

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: GestureDetector(
                onTap: () {
                  Utils.hideKeyboard();
                },
                child: Column(
                  children: [
                    AppConstants.sizeBoxHeight10,
                    ItemTypeWidget(
                      title: "Type",
                      radioTitle1: "Service",
                      radioTitle2: "Goods",
                      isSeletedRadio1: isSeletedRadio1,
                      callbackRadio1: () {
                        isSeletedRadio1 = true;
                        reRenderUI();
                      },
                      callbackRadio2: () {
                        isSeletedRadio1 = false;
                        reRenderUI();
                      },
                    ),
                    AppConstants.sizeBoxHeight10,
                    NewInputViewWidget(
                      title: "Item Name",
                      hintText: "Item Name",
                      controller: itemNameController,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (val) {
                        _validateItemForm();
                      },
                    ),
                    NewInputViewWidget(
                      title: "SKU",
                      hintText: "SKU",
                      isRequired: false,
                      controller: skuController,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    NewMultilineInputWidget(
                      title: "Description",
                      hintText: "Tap to Enter",
                      controller: descController,
                      inputType: TextInputType.multiline,
                      inputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      isRequired: false,
                      showDivider: true,
                    ),
                    NewInputViewWidget(
                      title: "Rate",
                      hintText: "0.00",
                      controller: rateController,
                      isRequired: false,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                    NewInputViewWidget(
                      title: "Unit",
                      hintText: "Unit",
                      controller: unitController,
                      isRequired: false,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.done,
                    ),
                    BlocListener<TaxBloc, TaxState>(
                      listener: (context, state) {
                        if (state is TaxListSuccessState) {
                          debugPrint(
                              (state.taxListResEntity.data?.taxes?.length ?? 0)
                                  .toString());
                          taxes = state.taxListResEntity.data?.taxes ?? [];
                          debugPrint(
                              "Taxes First name new item: ${taxes.first.name}");
                        }
                      },
                      child: InputDropdownView(
                          title: "Tax",
                          defaultText: getTaxesValue(),
                          value: getTaxesValue(),
                          isRequired: false,
                          showDivider: false,
                          onPress: () {
                            showTaxPopup();
                          }),
                    ),
                    if (isSeletedRadio1 == false)
                      Column(
                        children: [
                          AppConstants.sizeBoxHeight10,
                          InPutSwitchWidget(
                              title: "Track Inventory",
                              context: context,
                              isRecurringOn: trackInventory,
                              onChanged: (val) {
                                trackInventory = val;
                                setState(() {});
                              },
                              showDivider: true),
                          if (trackInventory)
                            NewInputViewWidget(
                                title: "Current Stock",
                                hintText: "0",
                                isRequired: false,
                                inputAction: TextInputAction.done,
                                inputType: TextInputType.number,
                                controller: currentStockController),
                        ],
                      ),
                    if (isEdit) AppConstants.sizeBoxHeight10,
                    if (isEdit)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppPallete.white,
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AppAlertWidget(
                                          title: "Delete Item",
                                          message:
                                              "Are you sure you want to delete this item?",
                                          onTapDelete: () {
                                            debugPrint("on tap delete item");
                                            AutoRouter.of(context).maybePop();

                                            context.read<ItemBloc>().add(
                                                DeleteItemEvent(
                                                    deleteItemReqModel:
                                                        DeleteItemReqModel(
                                                            id: widget
                                                                    .itemListEntity
                                                                    ?.id ??
                                                                "")));
                                          },
                                        );
                                      });
                                },
                                child: Text(
                                  "Delete",
                                  style: AppFonts.regularStyle(
                                      color: AppPallete.red),
                                ))
                          ],
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        ));
  }

//MARK:- Helper methods
  bool get isEdit {
    if (widget.isFromDuplicate) {
      return false;
    }
    return widget.itemListEntity == null ? false : true;
  }

  AddIemReqModel getAddItemReqModel() {
    AddIemReqModel model = AddIemReqModel();
    if (!widget.isFromDuplicate && widget.itemListEntity != null) {
      model.id = widget.itemListEntity?.id;
    }
    model.name = itemNameController.text;
    model.description = descController.text;
    model.rate = rateController.text;
    model.sku = skuController.text;
    model.type = isSeletedRadio1 ? "Service" : "Goods";
    model.trackInventory = trackInventory ? "1" : "0";
    model.unit = unitController.text;
    model.stock = trackInventory ? currentStockController.text : "";
    model.taxes = "[${selectedTaxes?.map((element) {
      return element.id;
    }).join(",")}]";
    return model;
  }
}

class ItemTypeWidget extends StatelessWidget {
  final String title;
  final String radioTitle1;
  final String radioTitle2;
  final VoidCallback callbackRadio1;
  final VoidCallback callbackRadio2;
  final bool isSeletedRadio1;

  const ItemTypeWidget(
      {super.key,
      required this.title,
      required this.radioTitle1,
      required this.radioTitle2,
      required this.callbackRadio1,
      required this.callbackRadio2,
      required this.isSeletedRadio1});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Row(
        children: [
          Text(
            title,
            style: AppFonts.regularStyle(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: callbackRadio1,
                  child: SizedBox(
                    width: 95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (isSeletedRadio1)
                          const Icon(
                            Icons.check,
                            color: AppPallete.blueColor,
                          ),
                        AppConstants.sizeBoxWidth10,
                        Text(
                          radioTitle1,
                          style: AppFonts.regularStyle(),
                        )
                      ],
                    ),
                  ),
                ),
                AppConstants.sizeBoxWidth10,
                GestureDetector(
                  onTap: callbackRadio2,
                  child: SizedBox(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (isSeletedRadio1 == false)
                          const Icon(
                            Icons.check,
                            color: AppPallete.blueColor,
                          ),
                        AppConstants.sizeBoxWidth10,
                        Text(
                          radioTitle2,
                          style: AppFonts.regularStyle(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
