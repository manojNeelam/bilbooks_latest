import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/widgets/payment_reminder_popup_widget.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/core/widgets/time_zone_popup_widget.dart';
import 'package:billbooks_app/features/invoice/domain/entities/delivery_options_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_reminder_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_terms_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/repeat_every_model.dart';
import 'package:billbooks_app/features/invoice/domain/entities/time_zone_model.dart';
import 'package:flutter/material.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/input_switch_widget.dart';
import '../../../../core/widgets/item_separator.dart';
import '../../../../core/widgets/new_inputview_widget.dart';
import '../../../../core/widgets/new_multiline_input_widget.dart';
import '../../../../core/widgets/payment_terms_popup_widget.dart';
import '../../../../core/widgets/repeat_every_popup_widget.dart';
import '../../../../core/widgets/twolabel_dropdown_widget.dart';
import '../add_new_invoice_page.dart';
import '../../../../core/widgets/app_single_selection_popup.dart';

@RoutePage()
// ignore: must_be_immutable
class InvoiceAddBasicDetailsWidget extends StatefulWidget {
  InvoiceRequestModel invoiceRequestModel;
  Function()? callback;

  InvoiceAddBasicDetailsWidget(
      {Key? key, required this.invoiceRequestModel, required this.callback})
      : super(key: key);

  @override
  State<InvoiceAddBasicDetailsWidget> createState() =>
      _InvoiceAddBasicDetailsWidgetState();
}

class _InvoiceAddBasicDetailsWidgetState
    extends State<InvoiceAddBasicDetailsWidget> {
  DateTime selectedInvoiceDate = DateTime.now();
  late DeliveryOptionsResModel deliveryOptionsResModel;
  late PaymentReminderResModel paymentReminderResModel;
  late PaymentTermsResModel paymentTermsResModel;
  late RepeatEveryResModel repeatEveryResModel;
  late TimeZoneResModel timeZoneResModel;
  final TextEditingController invoiceHeadingController =
      TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController invoiceNoController = TextEditingController();
  final TextEditingController poNoController = TextEditingController();
  final TextEditingController remainingController = TextEditingController();

  DeliveryOption? selectedDeliveryOption;
  bool isRecurringOn = false;
  bool isInfinite = false;
  List<PaymentTerms> paymentTerms = [];
  List<PaymentReminder> paymentReminders = [];
  PaymentTerms? selectedPaymentTerms;
  List<RepeatEvery> repeatEveryList = [];
  RepeatEvery? selectedRepeatEvery;
  List<Timezone> timeZones = [];
  Timezone? selectedTimezones;
  PaymentReminder? selectedPaymentReminder;

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedInvoiceDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppPallete.blueColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, //// <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppPallete.blueColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != selectedInvoiceDate) {
      setState(() {
        selectedInvoiceDate = picked;
      });
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() {
    _populateData();
    readDeliveryOptions();
    readPaymentReminder();
    _readPaymentTerms();
    readRepeatEvery();
    readTimeZones();
  }

  void _populateData() {
    final reqModel = widget.invoiceRequestModel;
    invoiceHeadingController.text = reqModel.heading ?? "";
    invoiceNoController.text = reqModel.no ?? "";
    titleController.text = reqModel.title ?? "";
    poNoController.text = reqModel.poNumber ?? "";
    isRecurringOn = reqModel.isRecurring ?? false;
    selectedPaymentTerms = reqModel.selectedPaymentTerms;
    selectedPaymentReminder = reqModel.selectedPaymentReminder;
    selectedRepeatEvery = reqModel.selectedRepeatEvery;
    selectedTimezones = reqModel.selectedTimezones;
    selectedDeliveryOption = reqModel.selectedDeliveryOption;
    remainingController.text = reqModel.remaining ?? "";
    selectedTimezones = reqModel.selectedTimezones;
    isInfinite = reqModel.isInfinite ?? false;
  }

  Future<void> readDeliveryOptions() async {
    final String response =
        await rootBundle.loadString('assets/files/delivery_options.json');
    deliveryOptionsResModel = deliveryOptionsResModelFromJson(response);
    final items = deliveryOptionsResModel.items ?? [];
    selectedDeliveryOption ??= items.firstOrNull;
    reRenderUI();
  }

  Future<void> readPaymentReminder() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_reminder.json');
    paymentReminderResModel = paymentReminderResModelFromJson(response);
    paymentReminders = paymentReminderResModel.items ?? [];

    selectedPaymentReminder ??= paymentReminders.firstWhere((returnedTerms) {
      return returnedTerms.label?.toLowerCase() == "none" ||
          returnedTerms.value == "0";
    });
    reRenderUI();
  }

  Future<void> _readPaymentTerms() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_terms.json');
    final res = paymentTermsResModelFromJson(response);
    paymentTerms = res.items ?? [];
    if (selectedPaymentTerms == null) {
      selectedPaymentTerms ??= paymentTerms.firstWhere((returnedTerms) {
        return returnedTerms.label?.toLowerCase() == "due on receipt" ||
            returnedTerms.value == "0";
      });
      reRenderUI();
    }
  }

  void reRenderUI() {
    setState(() {});
  }

  Future<void> readRepeatEvery() async {
    final String response =
        await rootBundle.loadString('assets/files/repeat_every.json');
    repeatEveryResModel = repeatEveryResModelFromJson(response);
    repeatEveryList = repeatEveryResModel.items ?? [];
    if (selectedRepeatEvery == null) {
      selectedRepeatEvery ??= repeatEveryList.firstWhere((returnedTerms) {
        return returnedTerms.label?.toLowerCase() == "week" ||
            returnedTerms.value == "0";
      });
      reRenderUI();
    }
  }

  Future<void> readTimeZones() async {
    final String response =
        await rootBundle.loadString('assets/files/time_zones.json');
    timeZoneResModel = timeZoneResModelFromJson(response);
    timeZones = timeZoneResModel.timezone ?? [];
    selectedTimezones ??= timeZones.firstOrNull;
    reRenderUI();
  }

  void _showRepaymentPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return PaymentTermsPopupWidget(
              paymentTerms: paymentTerms,
              defaultPaymentTerms: selectedPaymentTerms,
              callBack: (terms) {
                selectedPaymentTerms = terms;
                reRenderUI();
              });
        });
  }

  void _showPaymentReminderPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return PaymentReminderPopupWidget(
              paymentReminders: paymentReminders,
              defaultpaymentReminder: selectedPaymentReminder,
              callBack: (terms) {
                selectedPaymentReminder = terms;
                reRenderUI();
              });
        });
  }

  void _showTimezonePopup() {
    showDialog(
        context: context,
        builder: (context) {
          return TimeZonePopupWidget(
              timeZones: timeZones,
              defaultTimeZone: selectedTimezones,
              callBack: (terms) {
                selectedTimezones = terms;
                reRenderUI();
              });
        });
  }

  void _showRepeatEveryPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return RepeatEveryPopupWidget(
              defaultRepeatEvery: selectedRepeatEvery,
              repeatEvery: repeatEveryList,
              callBack: (repeatEvery) {
                selectedRepeatEvery = repeatEvery;
                reRenderUI();
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: const Text("Invoice Details"),
        actions: [
          TextButton(
              onPressed: () {
                widget.invoiceRequestModel.no = invoiceNoController.text;
                widget.invoiceRequestModel.selectedDeliveryOption =
                    selectedDeliveryOption;
                widget.invoiceRequestModel.heading =
                    invoiceHeadingController.text;
                widget.invoiceRequestModel.poNumber = poNoController.text;
                widget.invoiceRequestModel.title = titleController.text;
                widget.invoiceRequestModel.date = selectedInvoiceDate;
                widget.invoiceRequestModel.selectedPaymentTerms =
                    selectedPaymentTerms;
                widget.invoiceRequestModel.selectedPaymentReminder =
                    selectedPaymentReminder;
                widget.invoiceRequestModel.isRecurring = isRecurringOn;
                widget.invoiceRequestModel.selectedRepeatEvery =
                    selectedRepeatEvery;
                widget.invoiceRequestModel.remaining = remainingController.text;
                widget.invoiceRequestModel.selectedTimezones =
                    selectedTimezones;
                widget.invoiceRequestModel.isInfinite = isInfinite;
                widget.callback!();
                Navigator.of(context).pop();
              },
              child: Text(
                "Done",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              AppConstants.sizeBoxHeight10,
              NewInputViewWidget(
                title: 'Invoice Heading',
                hintText: "Heading",
                controller: invoiceHeadingController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                isRequired: true,
                showDivider: false,
              ),
              AppConstants.sizeBoxHeight10,
              NewMultilineInputWidget(
                title: 'Title/Summary',
                hintText: "e.g. description of invoice",
                controller: titleController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.newline,
                isRequired: false,
                showDivider: false,
                textCapitalization: TextCapitalization.words,
              ),
              AppConstants.sizeBoxHeight10,
              if (isRecurringOn == false)
                NewInputViewWidget(
                  title: 'Invoice #',
                  hintText: "Invoice #",
                  isBold: true,
                  controller: invoiceNoController,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  isRequired: true,
                ),
              InputDropdownView(
                  title: isRecurringOn ? "Start On" : "Invoice Date",
                  value: selectedInvoiceDate.getDateString(),
                  defaultText: selectedInvoiceDate.getDateString(),
                  isRequired: true,
                  showDropdownIcon: false,
                  onPress: () {
                    buildMaterialDatePicker(context);
                  }),
              NewInputViewWidget(
                title: 'P.O. Number',
                hintText: "P.O. Number",
                isRequired: false,
                controller: poNoController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.done,
              ),
              InputDropdownView(
                  title: "Payment Terms",
                  defaultText: "Tap to Select",
                  value: selectedPaymentTerms?.label ?? "",
                  isRequired: false,
                  onPress: () {
                    _showRepaymentPopup();
                  }),
              InputDropdownView(
                  title: "Payment Reminders",
                  defaultText: "None",
                  value: selectedPaymentReminder?.label ?? "Tap to Select",
                  showDivider: false,
                  isRequired: false,
                  onPress: () {
                    print("On press dropdown");
                    _showPaymentReminderPopup();
                  }),
              AppConstants.sizeBoxHeight10,
              InPutSwitchWidget(
                  title: "Recurring",
                  context: context,
                  showDivider: true,
                  isRecurringOn: isRecurringOn,
                  onChanged: (val) {
                    isRecurringOn = val;
                    debugPrint("Recurring: $val");
                    setState(() {});
                  }),
              if (isRecurringOn)
                Column(
                  children: [
                    InputDropdownView(
                        title: "Repeat Every",
                        defaultText: "Week",
                        value: selectedRepeatEvery?.label ?? "Tap to Select",
                        showDivider: false,
                        isRequired: false,
                        onPress: () {
                          _showRepeatEveryPopup();
                        }),
                    const SectionHeaderWidget(title: "How Many?"),
                    InPutSwitchWidget(
                        title: "Infinite",
                        showDivider: true,
                        context: context,
                        isRecurringOn: isInfinite,
                        onChanged: (val) {
                          isInfinite = val;
                          debugPrint("Infinite: $val");
                          setState(() {});
                        }),
                    if (isInfinite == false)
                      NewInputViewWidget(
                        title: 'Remaining',
                        hintText: "Remaining",
                        isRequired: false,
                        controller: remainingController,
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.done,
                      ),
                    AppConstants.sizeBoxHeight10,
                    TwoLabelsDropDownWidget(
                      title: "Delivery Options",
                      value: selectedDeliveryOption?.label ?? "Tap to Select",
                      onClickDropDown: () {
                        _openDeliveryOptions();
                      },
                      showDivider: true,
                    ),
                    TwoLabelsDropDownWidget(
                      title: "Timezone",
                      value:
                          "(${selectedTimezones?.gmt ?? ""}) ${selectedTimezones?.name ?? ""}",
                      onClickDropDown: () {
                        _showTimezonePopup();
                      },
                      showDivider: false,
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  void _openDeliveryOptions() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppSingleSelectionPopupWidget(
            defaultSelectedItem: selectedDeliveryOption,
            data: deliveryOptionsResModel.items!,
            title: "Delivery Options",
            selectedOk: (val) {
              selectedDeliveryOption = val;
              reRenderUI();
            },
            itemBuilder: (item, seletedItem) {
              selectedDeliveryOption = seletedItem;
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
                              item.label ?? "NA",
                              style: AppFonts.regularStyle(
                                  color: selectedDeliveryOption?.label ==
                                          item.label
                                      ? AppPallete.blueColor
                                      : AppPallete.textColor),
                            ),
                          ),
                          AppConstants.sizeBoxWidth10,
                          if (selectedDeliveryOption?.label == item.label)
                            const SizedBox(
                              width: 25,
                              height: 25,
                              child: Icon(
                                Icons.check,
                                color: AppPallete.blueColor,
                              ),
                            ),
                          if (selectedDeliveryOption?.label != item.label)
                            const SizedBox(
                              width: 25,
                              height: 25,
                            ),
                        ],
                      ),
                    ),
                    const ItemSeparator()
                  ],
                ),
              );
            },
          );
        });
  }
}

class InvoiceInfoPopupDataModel {
  String id;
  String title;
  InvoiceInfoPopupDataModel({required this.id, required this.title});
}
