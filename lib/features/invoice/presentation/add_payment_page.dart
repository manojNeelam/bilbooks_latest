import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/input_switch_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/new_multiline_input_widget.dart';
import 'package:billbooks_app/core/widgets/payment_method_popup_widget.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/payment_method_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/add_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/delete_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/date_picker_widget.dart';
import '../../../router/app_router.dart';

@RoutePage()
class AddPaymentPage extends StatefulWidget {
  final String balanceAmount;
  final String id;
  final PaymentEntity? paymentEntity;
  final Function() refreshPage;
  final List<EmailtoMystaffEntity> emailList;
  final Function() startObserveBlocBack;

  const AddPaymentPage({
    super.key,
    required this.balanceAmount,
    required this.id,
    this.paymentEntity,
    required this.refreshPage,
    required this.emailList,
    required this.startObserveBlocBack,
  });

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  bool sendThankYou = false;
  List<PaymentMethodEntity> paymentMethods = [];
  PaymentMethodEntity? selectedPaymentMethod;
  DateTime initialDate = DateTime.now();
  List<EmailtoMystaffEntity> selectedStaffEmail = [];

  @override
  void initState() {
    loadPaymentMethods();
    if (isEdit()) {
      _populateData();
    } else {
      amountController.text = widget.balanceAmount;
      selectedStaffEmail = widget.emailList.where((element) {
        return element.selected == true;
      }).toList();
    }
    super.initState();
  }

  void _populateData() {
    final item = widget.paymentEntity;
    if (item != null) {
      amountController.text = item.amount ?? "";
      notesController.text = item.notes ?? "";
      referenceController.text = item.refno ?? "";
      if (item.dateYmd != null) {
        initialDate = item.dateYmd ?? DateTime.now();
      }
    }
  }

  bool isEdit() {
    return widget.paymentEntity != null;
  }

  void selectedPaymentMethodFor({required PaymentEntity? paymentEntity}) {
    if (paymentMethods.isNotEmpty && paymentEntity != null) {
      final methodName = paymentEntity.methodName ?? "";
      final index = paymentMethods.indexWhere(
        (returnedItem) {
          final name = returnedItem.name ?? "";
          if (name.isNotEmpty) {
            return name.toLowerCase() == methodName.toLowerCase();
          }
          return false;
        },
      );
      if (index >= 0) {
        selectedPaymentMethod = paymentMethods[index];
      }
    }
  }

  Future<void> loadPaymentMethods() async {
    final String response =
        await rootBundle.loadString('assets/files/payment_method.json');
    final model = paymentMethodMainResEntityFromJson(response);
    paymentMethods = model.list ?? [];
    if (paymentMethods.isNotEmpty) {
      if (isEdit()) {
        selectedPaymentMethodFor(paymentEntity: widget.paymentEntity);
      } else {
        selectedPaymentMethod = paymentMethods.first;
      }
      setState(() {});
    }
  }

  void _addNewPayment() {
    context.read<InvoiceBloc>().add(AddPaymentEvent(
        params: AddPaymentUsecaseReqParms(
            id: widget.paymentEntity?.id ?? "",
            amount: amountController.text,
            sendThankYou: false,
            method: selectedPaymentMethod?.methodId ?? "",
            refno: referenceController.text,
            notes: notesController.text,
            date: initialDate.getDateString(),
            invoiceId: widget.id)));
  }

  void _openEmailTo() {
    AutoRouter.of(context).push(EmailToPageRoute(
        clientStaff: widget.emailList,
        myStaffList: const [],
        selectedClientStaff: selectedStaffEmail,
        selectedMyStaffList: const [],
        onpressDone: (myStaff, clientStafff) {
          selectedStaffEmail = clientStafff;
          setState(() {});
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: Text(isEdit() ? "Edit Payment" : "Add Payment"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {
                _addNewPayment();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        leading: IconButton(
            onPressed: () {
              widget.startObserveBlocBack();
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
      ),
      body: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is DeletePaymentSuccessState) {
            showToastification(
                context,
                state.deletePaymentMethodMainResEntity.data?.message ??
                    "Successfully deleted payment",
                ToastificationType.success);
            widget.refreshPage();
            AutoRouter.of(context).maybePop();
          }
          if (state is AddPaymentSuccessState) {
            showToastification(
                context,
                state.addPaymentMethodMainResEntity.data?.message ??
                    "Successfully added payment",
                ToastificationType.success);
            widget.refreshPage();
            AutoRouter.of(context).maybePop();
          }
          if (state is AddPaymentErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is DeletePaymentErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is AddPaymentLoadingState) {
            return LoadingPage(
                title: isEdit() ? "Updating payment..." : "Adding payment...");
          }
          if (state is DeletePaymentLoadingState) {
            return const LoadingPage(title: "Deleting payment...");
          }
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Container(
                  color: AppPallete.kF2F2F2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  child: Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: AppFonts.mediumStyle(size: 18),
                              text: "\$${widget.balanceAmount}",
                              children: [
                            const TextSpan(text: " "),
                            TextSpan(
                                text: "Outstanding",
                                style: AppFonts.regularStyle(
                                    size: 12, color: AppPallete.k666666))
                          ])),
                    ],
                  ),
                ),
                InputDropdownView(
                  isRequired: true,
                  title: "Date",
                  value: initialDate.getDateString(),
                  defaultText: "Tap to Select",
                  onPress: () async {
                    initialDate =
                        await buildMaterialDatePicker(context, initialDate) ??
                            DateTime.now();
                    setState(() {});
                  },
                ),
                NewInputViewWidget(
                  title: "Amount",
                  hintText: "0.00",
                  controller: amountController,
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                InputDropdownView(
                    title: "Payment Method",
                    defaultText: "Tap to Select",
                    value: selectedPaymentMethod?.name ?? "",
                    onPress: () {
                      _showPaymentReminderPopup();
                    }),
                NewInputViewWidget(
                  title: "Reference #",
                  hintText: "Reference #",
                  isRequired: false,
                  controller: referenceController,
                ),
                NewMultilineInputWidget(
                  title: "Notes",
                  hintText: "Tap to Enter",
                  isRequired: false,
                  controller: notesController,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.newline,
                  showDivider: false,
                ),
                AppConstants.sizeBoxHeight10,
                InPutSwitchWidget(
                    title: "Send thank you email",
                    context: context,
                    isRecurringOn: sendThankYou,
                    onChanged: (val) {
                      if (val != sendThankYou) {
                        sendThankYou = val;
                        setState(() {});
                      }
                    },
                    showDivider: false),
                if (sendThankYou)
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        AppConstants.sizeBoxHeight10,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: AppPallete.white,
                          child: Padding(
                            padding: AppConstants.verticalPadding13,
                            child: GestureDetector(
                              onTap: () {
                                _openEmailTo();
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Email To",
                                    style: AppFonts.regularStyle(),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        getEmailValue(),
                                        style: AppFonts.regularStyle(),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: AppPallete.borderColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isEdit()) AppConstants.sizeBoxHeight10,
                if (isEdit())
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
                                      title: "Delete Payment",
                                      message:
                                          "Are you sure you want to delete this payment?",
                                      onTapDelete: () {
                                        debugPrint("on tap delete item");
                                        AutoRouter.of(context).maybePop();

                                        context.read<InvoiceBloc>().add(
                                            DeletePaymentEvent(
                                                params:
                                                    DeletePaymentUsecaseReqParams(
                                                        id: widget.paymentEntity
                                                                ?.id ??
                                                            "")));
                                      },
                                    );
                                  });
                            },
                            child: Text(
                              "Delete",
                              style:
                                  AppFonts.regularStyle(color: AppPallete.red),
                            ))
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getEmailValue() {
    return "${selectedStaffEmail.length} of ${widget.emailList.length} Contacts";
  }

  void _showPaymentReminderPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return PaymentMethodPopupWidget(
              paymentMethods: paymentMethods,
              defaultpaymentReminder: selectedPaymentMethod,
              callBack: (terms) {
                selectedPaymentMethod = terms;
                setState(() {});
              });
        });
  }
}
