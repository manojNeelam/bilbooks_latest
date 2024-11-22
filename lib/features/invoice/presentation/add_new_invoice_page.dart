import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/delivery_options_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/client_staff_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:billbooks_app/features/invoice/presentation/line_item_total_selection.dart';
import 'package:billbooks_app/features/project/domain/entity/project_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:toastification/toastification.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/notes_widget.dart';
import '../../../core/widgets/terms_card_widget.dart';
import '../../../router/app_router.dart';
import '../domain/entities/invoice_details_entity.dart';
import '../domain/entities/payment_reminder_model.dart';
import '../domain/entities/payment_terms_model.dart';
import '../domain/entities/repeat_every_model.dart';
import '../domain/entities/time_zone_model.dart';
import '../domain/usecase/add_invoice_usecase.dart';
import 'widgets/invoice_add_client_widget.dart';
import 'widgets/invoice_client_details_widget.dart';
import 'widgets/invoice_info_widget.dart';
import 'widgets/invoice_lineitem_widget.dart';
import 'widgets/itemdetails_amount_section_widget.dart';

enum EnumNewInvoiceEstimateType {
  invoice,
  estimate,
  editInvoice,
  editEstimate,
  duplicateEstimate,
  duplicateInvoice,
  convertEstimateToInvoice,
}

extension EnumNewInvoiceEstimateTypeExtension on EnumNewInvoiceEstimateType {
  String getName() {
    switch (this) {
      case EnumNewInvoiceEstimateType.estimate ||
            EnumNewInvoiceEstimateType.duplicateEstimate:
        return "Estimate";
      case EnumNewInvoiceEstimateType.invoice ||
            EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
            EnumNewInvoiceEstimateType.duplicateInvoice:
        return "Invoice";
      case EnumNewInvoiceEstimateType.editEstimate:
        return "Estimate";
      case EnumNewInvoiceEstimateType.editInvoice:
        return "Invoice";
    }
  }

  String getTitle() {
    switch (this) {
      case EnumNewInvoiceEstimateType.estimate ||
            EnumNewInvoiceEstimateType.duplicateEstimate:
        return "New Estimate";
      case EnumNewInvoiceEstimateType.invoice ||
            EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
            EnumNewInvoiceEstimateType.duplicateInvoice:
        return "New Invoice";
      case EnumNewInvoiceEstimateType.editEstimate:
        return "Edit Estimate";
      case EnumNewInvoiceEstimateType.editInvoice:
        return "Edit Invoice";
    }
  }
}

@RoutePage()
class AddNewInvoiceEstimatePage extends StatefulWidget {
  final InvoiceDetailResEntity? invoiceDetailResEntity;
  final InvoiceEntity? invoiceEntity;
  final EnumNewInvoiceEstimateType type;
  final Function() refreshCallBack;
  final Function() startObserveBlocBack;
  const AddNewInvoiceEstimatePage({
    super.key,
    this.invoiceEntity,
    required this.type,
    required this.refreshCallBack,
    required this.invoiceDetailResEntity,
    required this.startObserveBlocBack,
  });

  @override
  State<AddNewInvoiceEstimatePage> createState() =>
      _AddNewInvoiceEstimatePageState();
}

class _AddNewInvoiceEstimatePageState extends State<AddNewInvoiceEstimatePage>
    with SectionAdapterMixin {
  TextEditingController notesController = TextEditingController();
  InvoiceRequestModel invoiceRequestModel = InvoiceRequestModel();
  ClientEntity? selectedClient;
  ProjectEntity? selectedProject;
  List<EmailtoMystaffEntity> myStaffList = [];
  List<EmailtoMystaffEntity> clientStaff = [];

  List<EmailtoMystaffEntity> selectedMyStaffList = [];
  List<EmailtoMystaffEntity> selectedClientStaff = [];
  InvoiceDetailResEntity? invoiceDetailResEntity;
  List<InvoiceItemEntity> selectedLineItems = [];
  List<TaxEntity> taxesList = [];
  List<ItemTaxInfo> selectedItemTaxesList = [];
  String subTotal = "0.00";
  String netTotal = "0.00";
  String totalDiscount = "0.00";
  String totalFinalTaxAmountVal = "0.00";
  ShippingDiscountModel shippingDiscountModel = ShippingDiscountModel(
      discount: "0.00", shipping: "0.00", isPercentage: false);
  String terms = "";
  DeliveryOptionsResModel? deliveryOptionsResModel;
  PaymentReminderResModel? paymentReminderResModel;
  RepeatEveryResModel? repeatEveryResModel;
  TimeZoneResModel? timeZoneResModel;
  List<DeliveryOption> deliveryOptionList = [];
  List<PaymentReminder> paymentReminderList = [];
  List<PaymentTerms> paymentTermsList = [];
  List<RepeatEvery> repeatEveryitems = [];
  List<Timezone> timeZonesList = [];

  void calculateListOfTaxes() {
    if (selectedLineItems.isEmpty) {
      subTotal = "0.00";
      netTotal = "0.00";
      totalDiscount = "0.00";
      selectedItemTaxesList = [];
      return;
    }
    selectedItemTaxesList = [];
    double totalSubAmount = 0;

    for (final item in selectedLineItems) {
      final amount = item.amount ?? "0";
      final amountAsDouble = double.parse(amount);

      totalSubAmount += amountAsDouble;

      if (item.taxes != null && item.taxes!.isNotEmpty) {
        for (final tax in item.taxes!) {
          final rate = tax.rate ?? 0;
          final taxValue = (rate / 100) * amountAsDouble;

          final index = selectedItemTaxesList.indexWhere((returnedItem) {
            return returnedItem.id == tax.id;
          });
          if (index >= 0) {
            final amount = selectedItemTaxesList[index].amount; //10
            final appendAmount = taxValue + amount; //5 + 10 = 15
            selectedItemTaxesList[index] = ItemTaxInfo(
              id: tax.id ?? "",
              amount: appendAmount,
              name: tax.name ?? "",
              rate: tax.rate.toString(),
            );
          } else {
            selectedItemTaxesList.add(ItemTaxInfo(
              id: tax.id ?? "", //1
              amount: taxValue, //10
              name: tax.name ?? "", //GST
              rate: tax.rate.toString(), //10
            ));
          }
        }
      }
    }

    subTotal = totalSubAmount.toStringAsFixed(2);
    final discountRate = double.parse(shippingDiscountModel.discount);
    final discountValue = (discountRate / 100) * totalSubAmount;
    totalDiscount = discountValue.toStringAsFixed(2);
    debugPrint("Total Dis: $totalDiscount");

    final finalTaxAmountValue =
        selectedItemTaxesList.fold(0.0, (sum, item) => sum + item.amount);
    final shipping = double.parse(shippingDiscountModel.shipping);
    totalFinalTaxAmountVal = finalTaxAmountValue.toStringAsFixed(2);
    final netTotalAmount =
        (totalSubAmount + finalTaxAmountValue + shipping) - discountValue;
    netTotal = netTotalAmount.toStringAsFixed(2);
  }

  @override
  void initState() {
    if (isNewEstimateInvoice()) {
      context.read<InvoiceBloc>().add(GetInvoiceDetails(
          invoiceDetailRequest: InvoiceDetailRequest(type: widget.type)));
    } else {
      if (widget.type == EnumNewInvoiceEstimateType.duplicateInvoice ||
          widget.type == EnumNewInvoiceEstimateType.duplicateEstimate ||
          widget.type == EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
        context.read<InvoiceBloc>().add(GetInvoiceDetails(
            invoiceDetailRequest: InvoiceDetailRequest(type: widget.type)));
      }
      populateData();
    }
    super.initState();
  }

  void _loadInvoiceListData() async {
    await _readDeliveryOptions();
    await _readPaymentReminder();
    await _readRepeatEvery();
    await _readTimeZones();
    await _readPaymentTerms();
  }

  Future<void> _readDeliveryOptions() async {
    final String response =
        await rootBundle.loadString('assets/files/delivery_options.json');
    deliveryOptionsResModel = deliveryOptionsResModelFromJson(response);
    deliveryOptionList = deliveryOptionsResModel?.items ?? [];

    final deliveryOptions = widget.invoiceEntity?.deliveryOptions ?? "";
    if (deliveryOptions.isNotEmpty) {
      final deliveryOptionsIndex = deliveryOptionList.indexWhere((elemnet) {
        return elemnet.value == deliveryOptions;
      });
      if (deliveryOptionsIndex >= 0) {
        invoiceRequestModel.selectedDeliveryOption =
            deliveryOptionList[deliveryOptionsIndex];
      }
    }
  }

  Future<void> _readPaymentReminder() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_reminder.json');
    paymentReminderResModel = paymentReminderResModelFromJson(response);
    paymentReminderList = paymentReminderResModel?.items ?? [];

    final paymentReminders = widget.invoiceEntity?.paymentReminders ?? "";
    if (paymentReminders.isNotEmpty) {
      final paymentRemindersIndex = paymentReminderList.indexWhere((elemnet) {
        return elemnet.value == paymentReminders;
      });
      if (paymentRemindersIndex >= 0) {
        invoiceRequestModel.selectedPaymentReminder =
            paymentReminderList[paymentRemindersIndex];
      }
    }
  }

  Future<void> _readPaymentTerms() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_terms.json');
    final res = paymentTermsResModelFromJson(response);
    paymentTermsList = res.items ?? [];

    final dueTerms = widget.invoiceEntity?.dueTerms ?? "";
    if (dueTerms.isNotEmpty) {
      final payTermsIndex = paymentTermsList.indexWhere((elemnet) {
        return elemnet.value == dueTerms;
      });
      if (payTermsIndex >= 0) {
        invoiceRequestModel.selectedPaymentTerms =
            paymentTermsList[payTermsIndex];
      }
    }
  }

  void reRenderUI() {
    setState(() {});
  }

  Future<void> _readRepeatEvery() async {
    final String response =
        await rootBundle.loadString('assets/files/repeat_every.json');
    repeatEveryResModel = repeatEveryResModelFromJson(response);
    repeatEveryitems = repeatEveryResModel?.items ?? [];

    final frequency = widget.invoiceEntity?.frequency ?? "";
    if (frequency.isNotEmpty) {
      final freqIndex = repeatEveryitems.indexWhere((elemnet) {
        return elemnet.value == frequency;
      });
      if (freqIndex >= 0) {
        invoiceRequestModel.selectedRepeatEvery = repeatEveryitems[freqIndex];
      }
    }
  }

  Future<void> _readTimeZones() async {
    final String response =
        await rootBundle.loadString('assets/files/time_zones.json');
    timeZoneResModel = timeZoneResModelFromJson(response);
    timeZonesList = timeZoneResModel?.timezone ?? [];

    final timezoneId = widget.invoiceEntity?.timezoneId ?? "";
    if (timezoneId.isNotEmpty) {
      final timeZoneIndex = timeZonesList.indexWhere((elemnet) {
        return elemnet.timezoneId == timezoneId;
      });
      if (timeZoneIndex >= 0) {
        invoiceRequestModel.selectedTimezones = timeZonesList[timeZoneIndex];
      }
    }
  }

  DateTime? getDateFrom(String? dateStr) {
    if (dateStr == null) {
      return null;
    }
    try {
      final date = DateTime.parse(dateStr);
      debugPrint("DATE: ${date.toString()}");
      return date;
    } catch (e) {
      debugPrint("Unable to parse date string: ${e.toString()}");
      return null;
    }
  }

  void populateData() {
    selectedClient = ClientEntity(
      id: widget.invoiceEntity?.clientId,
      clientId: widget.invoiceEntity?.clientId,
      name: widget.invoiceEntity?.clientName,
      address: widget.invoiceEntity?.clientAddress,
    );
    terms = widget.invoiceEntity?.terms ?? "";
    myStaffList = widget.invoiceEntity?.emailtoMystaff ?? [];
    //clientStaff = widget.invoiceEntity?.emailtoClientstaff ?? [];
    selectedLineItems = widget.invoiceEntity?.items ?? [];
    invoiceRequestModel = InvoiceRequestModel(
      no: widget.invoiceEntity?.no ?? "",
      heading: widget.invoiceEntity?.heading ?? "",
      title: widget.invoiceEntity?.summary ?? "",
      poNumber: widget.invoiceEntity?.pono ?? "",
      remaining: widget.invoiceEntity?.howmany ?? "",
      status: widget.invoiceEntity?.status ?? "",
      expiryDate: getDateFrom(widget.invoiceEntity?.expirydateYmd),
      date: widget.invoiceEntity?.dateYmd,
    );
    /*
    "expiry_date": "30.08.2024",
     "expirydate_ymd": "2024-08-30",
    */
    if (!isEstimate()) {
      if (_isRecurring()) {
        final howMany = widget.invoiceEntity?.howmany ?? "";
        invoiceRequestModel.isRecurring = howMany.isNotEmpty;
      } else {
        invoiceRequestModel.isRecurring = false;
      }
      _loadInvoiceListData();
    }
    selectedMyStaffList = myStaffList.where((returnedItem) {
      return returnedItem.selected == true;
    }).toList();
    if (widget.invoiceEntity?.clientId != null) {
      getClientStaffBy(widget.invoiceEntity?.clientId ?? "");
    }
    selectedProject = ProjectEntity(
        id: widget.invoiceEntity?.projectId ?? "",
        name: widget.invoiceEntity?.projectName ?? "");
    subTotal = widget.invoiceEntity?.subtotal ?? "";
    netTotal = widget.invoiceEntity?.nettotal ?? "";
    totalDiscount = widget.invoiceEntity?.discount ?? "";
    final discountType = widget.invoiceEntity?.shipping ?? "";
    bool isPercentage = false;

    if (discountType == "0") {
      isPercentage = true;
    } else if (discountType == "1") {
      isPercentage = false;
    }
    shippingDiscountModel = ShippingDiscountModel(
        discount: widget.invoiceEntity?.discountValue ?? "",
        shipping: widget.invoiceEntity?.shipping ?? "",
        isPercentage: isPercentage);
    notesController.text = widget.invoiceEntity?.notes ?? "";

    selectedClientStaff = clientStaff.where((returnedItem) {
      return returnedItem.selected == true;
    }).toList();

    calculateListOfTaxes();
    setState(() {});
  }

  bool _isRecurring() {
    final status = widget.invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "recurring") {
      return true;
    }
    return false;
  }

  void addEstimate() {
    final reqParams = AddInvoiceReqParms(
      type: widget.type,
      terms: terms,
      selectedClient: selectedClient,
      notes: notesController.text,
      invoiceRequestModel: invoiceRequestModel,
      selectedMyStaffList: selectedMyStaffList,
      selectedClientStaff: selectedClientStaff,
      selectedLineItems: selectedLineItems,
      selectedProject: selectedProject,
      discount: totalDiscount,
      discountType: shippingDiscountModel.isPercentage ? "0" : "1",
      discountValue: shippingDiscountModel.discount,
      netTotal: netTotal,
      shipping: shippingDiscountModel.shipping,
      subTotal: subTotal,
      taxTotal: totalFinalTaxAmountVal,
      id: doNeedToPassId() ? widget.invoiceEntity?.id ?? "" : "",
    );

    debugPrint("${reqParams.invoiceRequestModel?.date ?? DateTime.now()}");

    context.read<InvoiceBloc>().add(AddInvoiceEstimateEvent(params: reqParams));
  }

  /*
  id:10319
client:23537
no:EST015
date:04 Jul 2023
project:
pono:
expiry_date:11 Jul 2023
summary:
currency:
exchange_rate:
subtotal:55
discount_type:0
discount_value:0
discount:0
taxtotal:5.5
shipping:0
nettotal:60.5
notes:Note Here
terms:asdf
items:[{"item":"20636","desc":"Backend application development using PHP, AJAX, MySQL","date":"2023-03-03","time":"24:45:45","custom":"","qty":1,"rate":55,"amount":55,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"45","name":"GST","rate":4}]},{"item":"20638","desc":"PHP, AJAX, MySQL","date":"2023-04-03","time":"24:45:45","custom":"Custome fields","qty":12,"rate":56.3,"amount":56.3,"disc":0,"disctype":"0","discApplied":false,"unit":"1","taxes":[{"id":"882","name":"Vat","rate":10},{"id":"7","name":"GST","rate":4}]}]
emailto_mystaff:[{"id":"2468","email":"abc@exaple.com"},{"id":"2469","email":"pqr@exaple.com"}]
emailto_clientstaff:[{"id":"23214","email":"abc@exaple.com"},{"id":"23216","email":"pqr@exaple.com"}]
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPallete.kF2F2F2,
        appBar: AppBar(
          title: Text(widget.type
              .getTitle()), //Text(isEdit() ? "Edit Invoice" : "New Invoice"),
          bottom: AppConstants.getAppBarDivider,
          leading: IconButton(
              onPressed: () {
                widget.startObserveBlocBack();
                AutoRouter.of(context).maybePop();
              },
              icon: const Icon(
                Icons.close,
                color: AppPallete.blueColor,
              )),
          actions: [
            TextButton(
                onPressed: () {
                  addEstimate();
                },
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
          ],
        ),
        body: BlocConsumer<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (state is ClientStaffSuccessState) {
              final clientStaffList =
                  state.clientStaffMainResEntity.data?.staffs ?? [];
              clientStaff = clientStaffList.map((returnedItem) {
                return EmailtoMystaffEntity(
                    email: returnedItem.email,
                    id: returnedItem.id,
                    name: returnedItem.name,
                    selected: returnedItem.primary);
              }).toList();
            }
            if (state is InvoiceEstimateAddErrorState) {
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }
            if (state is InvoiceEstimateAddSuccessState) {
              showToastification(
                  context,
                  state.addInvoiceMainResEntity.data?.message ??
                      "Successfully addes ${isEstimate() ? "estimate" : "invoice"}.",
                  ToastificationType.success);
              widget.refreshCallBack();
              AutoRouter.of(context).maybePop();
            }
            if (state is InvoiceDetailSuccessState) {
              InvoiceEntity? invoiceEntity;

              if (widget.type == EnumNewInvoiceEstimateType.duplicateInvoice ||
                  widget.type == EnumNewInvoiceEstimateType.invoice ||
                  widget.type ==
                      EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
                invoiceEntity = state.invoiceDetailResEntity.invoice;
              } else if (isEstimate()) {
                invoiceEntity = state.invoiceDetailResEntity.estimate;
              }

              debugPrint(
                  "InvoiceDetailSuccessState: ${invoiceEntity?.no ?? "No invoice number"}");

              if (widget.type == EnumNewInvoiceEstimateType.duplicateInvoice ||
                  widget.type == EnumNewInvoiceEstimateType.duplicateEstimate ||
                  widget.type ==
                      EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
                invoiceRequestModel.no = invoiceEntity?.no;
                setState(() {});
                return;
              }

              taxesList = state.invoiceDetailResEntity.taxes ?? [];
              myStaffList = invoiceEntity?.emailtoMystaff ?? [];
              invoiceDetailResEntity = state.invoiceDetailResEntity;
              invoiceRequestModel.no = invoiceEntity?.no;
              invoiceRequestModel.heading = invoiceEntity?.heading;
            } else if (state is InvoiceDetailsFailureState) {
              debugPrint("Error occured: ${state.errorMessage}");
              showToastification(
                  context, state.errorMessage, ToastificationType.error);
            }
          },
          builder: (context, state) {
            if (state is InvoiceEstimateAddLoadingState) {
              return LoadingPage(
                  title:
                      "${isEdit() ? "Updating" : "Adding"} ${isEstimate() ? "estimate" : "invoice"} data..");
            }
            if (state is InvoiceDetailsLoadingState) {
              return LoadingPage(
                  title:
                      "Loading ${isEstimate() ? "estimate" : "invoice"} data..");
            }
            return SectionListView.builder(
              adapter: this,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            );
          },
        ));
  }

  Widget getTaxCell(BuildContext context,
      {required String title,
      required String subTitle,
      required String value,
      bool isTotal = false,
      bool isSubTotal = false}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: isSubTotal
              ? Text(
                  title,
                  textAlign: TextAlign.end,
                  style: AppFonts.mediumStyle(size: 16),
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
                    color:
                        isTotal ? AppPallete.blueColor : AppPallete.textColor,
                  ),
          ),
        )
      ],
    );
  }

  Widget getItemFooter(BuildContext context) {
    // String getTotalSubTotal() {
    //   if (selectedLineItems.isEmpty) {
    //     return "A\$0.00";
    //   }
    //   final amountList = selectedLineItems.map((returnedItem) {
    //     if (returnedItem.amount != null) {
    //       return double.parse(returnedItem.amount ?? "0");
    //     }
    //   });
    //   final subTotal = amountList.reduce((a, b) => (a ?? 0) + (b ?? 0));
    //   return subTotal.toString();
    // }

    return Container(
      color: AppPallete.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppConstants.sizeBoxHeight15,
          GestureDetector(
            onTap: () {
              debugPrint("Open Add New Line Item Screen");
              _openLineitem(null, null);
            },
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: AppPallete.blueColor,
                      ),
                      AppConstants.sizeBoxWidth10,
                      Text(
                        "Add new line",
                        style:
                            AppFonts.regularStyle(color: AppPallete.blueColor),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppPallete.borderColor,
                )
              ],
            ),
          ),
          AppConstants.sizeBoxHeight15,
          const ItemSeparator(),
          AppConstants.sizeBoxHeight15,
          getTaxCell(context,
              title: "Subtotal",
              subTitle: "",
              value: "\$$subTotal",
              isSubTotal: true),
          AppConstants.sepSizeBox5,
          getTaxCell(context,
              title: "Discount",
              subTitle: "",
              value: "\$$totalDiscount",
              isSubTotal: false),
          AppConstants.sepSizeBox5,
          for (var taxItem in selectedItemTaxesList)
            Column(
              children: [
                getTaxCell(context,
                    title: "${taxItem.name} (${taxItem.rate}%)",
                    subTitle: "",
                    value: "\$${taxItem.amount.toStringAsFixed(2)}",
                    isSubTotal: false),
                AppConstants.sepSizeBox5,
              ],
            ),
          getTaxCell(context,
              title: "Shipping",
              subTitle: "",
              value: "\$${shippingDiscountModel.shipping}",
              isSubTotal: false),
          AppConstants.sizeBoxHeight15,
          const ItemSeparator(),
          AppConstants.sizeBoxHeight15,
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).push(LineItemTotalSelectionPageRoute(
                  shippingDiscountModel: shippingDiscountModel,
                  callBack: (returnedShippingDiscountModel) {
                    shippingDiscountModel = returnedShippingDiscountModel;
                    calculateListOfTaxes();
                    setState(() {});
                  }));
            },
            child: getTaxCell(context,
                title: "Total",
                subTitle: "(USD)",
                value: "\$$netTotal",
                isTotal: true),
          ),
          AppConstants.sizeBoxHeight15,
        ],
      ),
    );
  }

  bool isEdit() {
    return widget.invoiceEntity != null;
  }

  void _rerenderUI() {
    setState(() {});
  }

  void _openProject() {
    AutoRouter.of(context).push(ProjectPopupRoute(
        clientId: selectedClient?.clientId,
        selectedClient: selectedClient,
        selectedProject: selectedProject,
        onSelectProject: (project) {
          selectedProject = project;
          setState(() {});
        }));
  }

  void _openLineitem(InvoiceItemEntity? lineItem, int? index) {
    AutoRouter.of(context).push(AddNewLineItemPageRoute(
        updateIndex: index,
        updateLineItem: lineItem,
        taxes: taxesList,
        enterItemModel: (lineItem, returnedIndex) {
          if (lineItem == null) {
            return;
          }
          if (returnedIndex != null) {
            selectedLineItems[returnedIndex] = lineItem;
          } else {
            selectedLineItems.add(lineItem);
          }

          calculateListOfTaxes();

          setState(() {});
        },
        items: invoiceDetailResEntity?.items));
  }

  void _openClient() {
    AutoRouter.of(context).push(ClientPopupRoute(
        clientListFromParentClass: invoiceDetailResEntity?.clients,
        selectedClient: selectedClient,
        onSelectClient: (client) {
          if (client != null &&
              selectedClient != null &&
              client.clientId == selectedClient?.clientId) {
            return;
          }
          selectedProject = null;
          selectedClientStaff = [];
          selectedClient = client;
          clientStaff = client?.persons?.map((returnedItem) {
                return EmailtoMystaffEntity(
                    email: returnedItem.email ?? "",
                    id: returnedItem.id ?? "",
                    name: returnedItem.name ?? "",
                    selected: returnedItem.primary ?? false);
              }).toList() ??
              [];
          if (client?.id != null) {
            getClientStaffBy(client?.id ?? "");
          }
          _rerenderUI();
        }));
  }

  void getClientStaffBy(String id) {
    context
        .read<InvoiceBloc>()
        .add(GetClientStaffEvent(params: ClientStaffUsecaseReqParams(id: id)));
  }

  bool doNeedToPassId() {
    switch (widget.type) {
      case EnumNewInvoiceEstimateType.estimate ||
            EnumNewInvoiceEstimateType.duplicateEstimate ||
            EnumNewInvoiceEstimateType.invoice ||
            EnumNewInvoiceEstimateType.duplicateInvoice:
        return false;
      case EnumNewInvoiceEstimateType.editInvoice ||
            EnumNewInvoiceEstimateType.editEstimate ||
            EnumNewInvoiceEstimateType.convertEstimateToInvoice:
        return true;
    }
  }

  bool isNewEstimateInvoice() {
    if (widget.type == EnumNewInvoiceEstimateType.estimate ||
        widget.type == EnumNewInvoiceEstimateType.invoice) {
      return true;
    }
    return false;
  }

  bool isEstimate() {
    if (widget.type == EnumNewInvoiceEstimateType.estimate ||
        widget.type == EnumNewInvoiceEstimateType.editEstimate ||
        widget.type == EnumNewInvoiceEstimateType.duplicateEstimate) {
      return true;
    }
    return false;
  }

  void _openEmailTo() {
    AutoRouter.of(context).push(EmailToPageRoute(
        clientStaff: clientStaff,
        myStaffList: myStaffList,
        selectedClientStaff: selectedClientStaff,
        selectedMyStaffList: selectedMyStaffList,
        onpressDone: (myStaff, clientStafff) {
          selectedClientStaff = clientStafff;
          selectedMyStaffList = myStaff;
          setState(() {});
        }));
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    if (indexPath.section == 5) {
      return Container(
          width: MediaQuery.of(context).size.width,
          color: AppPallete.white,
          child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AppAlertWidget(
                        title:
                            "Delete ${isEstimate() ? "Estimate" : "Invoice"}",
                        message:
                            "Are you sure you want to delete this ${isEstimate() ? "estimate" : "invoice"}?",
                        onTapDelete: () {
                          debugPrint("on tap delete item");
                          AutoRouter.of(context).maybePop();
                        },
                      );
                    });
              },
              child: Text(
                "Delete",
                style: AppFonts.regularStyle(color: AppPallete.red),
              )));
    }
    if (indexPath.section == 0) {
      return GestureDetector(
        child: InvoiceInfoWidget(
          invoiceStatusColor: widget.invoiceEntity?.statusColor,
          invoiceRequestModel: invoiceRequestModel,
          type: widget.type,
        ),
        onTap: () {
          if (isEstimate()) {
            AutoRouter.of(context).push(EstimateAddInfoDetailsRoute(
                invoiceRequestModel: invoiceRequestModel,
                callback: () {
                  setState(() {});
                }));
          } else {
            AutoRouter.of(context).push(InvoiceAddBasicDetailsWidgetRoute(
                invoiceRequestModel: invoiceRequestModel,
                callback: () {
                  setState(() {});
                }));
          }
        },
      );
    } else if (indexPath.section == 1) {
      if (selectedClient != null) {
        return InvoiceClientDetailsWidget(
          clientEntity: selectedClient!,
          onTapOpenEmailTo: () {
            _openEmailTo();
          },
          onTapOpenProjects: () {
            _openProject();
          },
          onTapOpenSelectClient: () {
            _openClient();
          },
          projectValue: selectedProject?.name,
          emailToVlaue:
              "${selectedClientStaff.length + selectedMyStaffList.length} of ${clientStaff.length + myStaffList.length} Contacts",
        );
      }
      return InvoiceAddClientWidget(
        onPress: () {
          _openClient();
        },
      );
    } else if (indexPath.section == 3) {
      return NotesWidget(
        controller: notesController,
        title: "Notes",
        hintText: isEstimate()
            ? "Will be displayed on the estimate"
            : "Will be displayed on the invoice",
      );
    } else if (indexPath.section == 4) {
      return TermsCardWidget(
        onPress: () {
          AutoRouter.of(context).push(InvoiceEstimateTermsInoutPageRoute(
              terms: terms,
              callback: (val) {
                terms = val;
              }));
        },
      );
    } else if (indexPath.section == 2) {
      final item = selectedLineItems[indexPath.item];
      return GestureDetector(
        onTap: () {
          debugPrint("selectedLineItems: ${item.description}");
          _openLineitem(item, indexPath.item);
        },
        child: SwipeActionCell(
          key: ObjectKey(item),
          trailingActions: [
            SwipeAction(
                style: AppFonts.regularStyle(color: AppPallete.white),
                title: "Delete",
                onTap: (CompletionHandler handler) async {
                  selectedLineItems.remove(item);
                  calculateListOfTaxes();
                  setState(() {});
                },
                color: Colors.red),
          ],
          child: InvoiceLineitemWidget(
            itemListEntity: item,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  @override
  int numberOfSections() {
    return isEdit() ? 6 : 5;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  bool shouldExistSectionFooter(int section) {
    if (section == 2) {
      return true;
    }
    return false;
  }

  @override
  Widget getSectionFooter(BuildContext context, int section) {
    if (section == 2) {
      return getItemFooter(context);
    }
    return const SizedBox();
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    if (section == 0) {
      return const SepHeader10hF2F2F2Widget();
    } else if (section == 1) {
      return const SectionHeaderWidget(title: "Client Details");
    } else if (section == 2) {
      return const ItemDetailsAmountSectionWidget();
    } else {
      return const SepHeader10hF2F2F2Widget();
    }
  }

  @override
  int numberOfItems(int section) {
    if (section == 2) {
      debugPrint("selectedLineItems length: ${selectedLineItems.length}");
      return selectedLineItems.length;
    }
    return 1;
  }
}

class SepHeader10hF2F2F2Widget extends StatelessWidget {
  const SepHeader10hF2F2F2Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      color: AppPallete.kF2F2F2,
    );
  }
}

/*
List<PaymentTerms> paymentTerms = [];
  List<PaymentReminder> paymentReminders = [];
  PaymentTerms? selectedPaymentTerms;
  List<RepeatEvery> repeatEveryList = [];
  RepeatEvery? selectedRepeatEvery;
  List<Timezone> timeZones = [];
  Timezone? selectedTimezones;
  PaymentReminder? selectedPaymentReminder;
*/
class InvoiceRequestModel {
  String? no;
  String? heading;
  String? title;
  DateTime? date;
  String? poNumber;
  bool? isRecurring;
  bool? isInfinite;
  String? remaining;
  String? status;
  DateTime? expiryDate;
  PaymentTerms? selectedPaymentTerms;
  RepeatEvery? selectedRepeatEvery;
  Timezone? selectedTimezones;
  PaymentReminder? selectedPaymentReminder;
  DeliveryOption? selectedDeliveryOption;

  InvoiceRequestModel({
    this.no,
    this.heading,
    this.isInfinite,
    this.remaining,
    this.selectedRepeatEvery,
    this.selectedTimezones,
    this.selectedPaymentTerms,
    this.selectedPaymentReminder,
    this.status,
    this.isRecurring,
    this.title,
    this.date,
    this.expiryDate,
    this.poNumber,
    this.selectedDeliveryOption,
  });
}

class ItemTaxInfo {
  final String id;
  final String name;
  final String rate;
  final double amount;
  ItemTaxInfo({
    required this.id,
    required this.amount,
    required this.name,
    required this.rate,
  });
}
