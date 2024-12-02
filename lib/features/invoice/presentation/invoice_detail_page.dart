import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_list_entity.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/delete_payment_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/get_document_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_delete_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_unvoid_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_usecase.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/invoice_void_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/add_new_invoice_page.dart';
import 'package:billbooks_app/features/invoice/presentation/bloc/invoice_bloc.dart';
import 'package:billbooks_app/features/invoice/presentation/send_invoice_estimate_page.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/itemdetails_amount_section_widget.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/items_details_card_widget.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:toastification/toastification.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../domain/usecase/invoice_markassend_usecase.dart';
import 'invoice_action_button.dart';
import 'widgets/history_item_widget.dart';
import 'widgets/invoice_details_info_widget.dart';
import 'widgets/items_tax_amount_details_widget.dart';
import 'widgets/payment_item_widget.dart';
import 'dart:async';

@RoutePage()
class InvoiceDetailPage extends StatefulWidget {
  final EnumNewInvoiceEstimateType type;
  final InvoiceEntity invoiceEntity;
  final String estimateTitle;
  final Function()? refreshList;
  final Function() startObserveBlocBack;
  const InvoiceDetailPage(
      {super.key,
      required this.invoiceEntity,
      required this.type,
      this.refreshList,
      required this.startObserveBlocBack,
      required this.estimateTitle});

  @override
  State<InvoiceDetailPage> createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage>
    with SectionAdapterMixin {
  InvoiceDetailResEntity? invoiceDetailResEntity;
  InvoiceEntity? invoiceEntity;
  bool isIgnoreBlocStates = false;
  bool callRefresh = false;
  BuildContext? mainContext;

  @override
  void initState() {
    mainContext = context;
    _loadData();
    super.initState();
  }

  void _loadData() {
    context.read<InvoiceBloc>().add(GetInvoiceDetails(
        invoiceDetailRequest: InvoiceDetailRequest(
            id: widget.invoiceEntity.id, type: widget.type)));
  }

  void _popOut() {
    if (callRefresh && widget.refreshList != null) {
      widget.refreshList!();
    }
    AutoRouter.of(context).maybePop();
  }

  Future<String> estimateTitle() async {
    if (widget.type == EnumNewInvoiceEstimateType.estimate) {
      return await Utils.getEstimate() ?? "Estimate";
    } else {
      return "Invoice";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                _editInvoiceEntity();
              },
              child: Text(
                "Edit",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        leading: IconButton(
            onPressed: () {
              widget.startObserveBlocBack();
              _popOut();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
        backgroundColor: AppPallete.lightBlueColor,
        title: FutureBuilder(
          future: estimateTitle(),
          initialData: "",
          builder: (context, snapshot) {
            return Text(snapshot.data ?? "NO Data");
          },
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (isIgnoreBlocStates == false) {
              if (state is InvoiceDeleteErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }

              if (state is InvoiceVoidErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }

              if (state is InvoiceDeleteSuccessState) {
                showToastification(
                    context,
                    state.invoiceDeleteMainResEntity.data?.message ??
                        "Successfully deleted",
                    ToastificationType.success);
                callRefresh = true;
                _popOut();
              }

              if (state is InvoiceVoidSuccessState) {
                showToastification(
                    context,
                    state.invoiceVoidMainResEntity.data?.message ??
                        "Successfully voided",
                    ToastificationType.success);
                callRefresh = true;
                _loadData();
              }

              if (state is InvoiceUnVoidErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }
              if (state is InvoiceUnVoidSuccessState) {
                showToastification(
                    context,
                    state.invoiceUnVoidMainResEntity.data?.message ??
                        "Successfully unvoided.",
                    ToastificationType.success);
                callRefresh = true;
                _loadData();
              }

              if (state is InvoiceMarkAsSendErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }
              if (state is InvoiceMarkAsSendSuccessState) {
                showToastification(
                    context,
                    state.invoiceMarksendMainResEntity.data?.message ??
                        "Successfully marked as sent.",
                    ToastificationType.success);
                callRefresh = true;
                _loadData();
              }

              if (state is DeletePaymentSuccessState) {
                showToastification(
                    context,
                    state.deletePaymentMethodMainResEntity.data?.message ??
                        "Successfully deleted payment.",
                    ToastificationType.success);
                callRefresh = true;
                _loadData();
              }
              if (state is DeletePaymentErrorState) {
                showToastification(
                    context, state.errorMessage, ToastificationType.error);
              }
              if (state is InvoiceDetailSuccessState) {
                invoiceDetailResEntity = state.invoiceDetailResEntity;
                if (widget.type == EnumNewInvoiceEstimateType.invoice) {
                  invoiceEntity = state.invoiceDetailResEntity.invoice;
                } else if (widget.type == EnumNewInvoiceEstimateType.estimate) {
                  invoiceEntity = state.invoiceDetailResEntity.estimate;
                }
                debugPrint("InvoiceDetailSuccessState");
                debugPrint(
                    "Pyaments length: ${state.invoiceDetailResEntity.payments?.length}");
                debugPrint(
                    "Total Items length: ${state.invoiceDetailResEntity.items?.length}");
                debugPrint(
                    "Items length: ${state.invoiceDetailResEntity.invoice?.items?.length}");
                debugPrint(
                    "History length: ${state.invoiceDetailResEntity.history?.length}");
                setState(() {});
              }
              if (state is InvoiceDetailsFailureState) {
                debugPrint("InvoiceDetailsFailureState");
                debugPrint("Error message: ${state.errorMessage}");
              }
            }
          },
          builder: (context, state) {
            if (isIgnoreBlocStates == false) {
              if (state is InvoiceDeleteLoadingState) {
                return const LoadingPage(title: "Deleting invoice...");
              }

              if (state is InvoiceVoidLoadingState) {
                return const LoadingPage(title: "Voiding invoice...");
              }
              if (state is InvoiceUnVoidLoadingState) {
                return const LoadingPage(title: "Unvoiding invoice...");
              }
              if (state is InvoiceMarkAsSendLoadingState) {
                return const LoadingPage(title: "Marking as sent...");
              }
              if (state is InvoiceDetailsLoadingState) {
                return const LoadingPage(title: "Loading details...");
              }
              if (state is DeletePaymentLoadingState) {
                return const LoadingPage(title: "Deleting payment...");
              }
            }
            return SectionListView.builder(adapter: this);
          },
        ),
      ),
    );
  }

  Widget headerCell(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, top: 5),
      decoration: const BoxDecoration(color: AppPallete.lightBlueColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cientName,
            style: AppFonts.regularStyle(size: 18),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Text(
            "${invoiceEntity?.displayNetTotal}",
            style: AppFonts.mediumStyle(color: AppPallete.blueColor, size: 24),
          ),

          Offstage(
            offstage: !isOverDue(),
            child: Column(
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "${invoiceEntity?.dueDaysDisplayText}".toUpperCase(),
                  style:
                      AppFonts.mediumStyle(color: AppPallete.k666666, size: 12),
                ),
              ],
            ),
          ),

          getHeaderCells(),
          // Text(
          //   "DUE ${invoiceEntity?.dueTerms} DAY AGO",
          //   style: AppFonts.regularStyle(color: AppPallete.k666666, size: 14),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }

  String get cientName {
    final name = invoiceEntity?.clientName ?? "";
    if (name.isNotEmpty) {
      return name.capitalize();
    }
    return name;
  }

  Widget getHeaderCells() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          editItem(context),
          isInvoice()
              ? isVoid()
                  ? unVoidItem()
                  : isPaid()
                      ? thankYouItem()
                      : isDraft() == true
                          ? sendItem(context)
                          : paymentsItem()
              : isInvoiced()
                  ? viewPDFItem()
                  : isSent()
                      ? viewNewInvoice()
                      : sendItem(context),
          isInvoice()
              ? isPaid()
                  ? viewPDFItem()
                  : (isDraft() == true || isVoid() == true)
                      ? viewPDFItem()
                      : reminderItem(context)
              : isInvoiced()
                  ? printPDFItem()
                  : viewPDFItem(),
          viewMoreItem(),
        ],
      ),
    );
  }

  Widget viewNewInvoice() {
    return GestureDetector(
      onTap: () {
        isInvoice() ? showInvoiceViewMore() : _convertToInvoice();
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.invoice),
    );
  }

  Widget viewMoreItem() {
    return GestureDetector(
      onTap: () {
        isInvoice() ? showInvoiceViewMore() : showEstimateViewMore();
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.more),
    );
  }

  Widget printPDFItem() {
    return GestureDetector(
      onTap: () {
        _getPdfContent();
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.printpdf),
    );
  }

  Widget viewPDFItem() {
    return GestureDetector(
      onTap: () {
        _getPdfContent();
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.viewpdf),
    );
  }

  Widget unVoidItem() {
    return GestureDetector(
      onTap: () {
        _showUnVoidAlert();
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.unVoid),
    );
  }

  Widget thankYouItem() {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
            params: GetDocumentUsecaseReqParams(
                pageType: EnumSendPageType.thankyou,
                type: isInvoice()
                    ? EnumDocumentType.invoice
                    : EnumDocumentType.estimate,
                id: widget.invoiceEntity.id ?? "")));
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.thankYou),
    );
  }

  Widget paymentsItem() {
    return GestureDetector(
      onTap: () {
        _openPaymentPage();
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.payment),
    );
  }

  Widget sendItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTapSendDoc();
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.send),
    );
  }

  Widget reminderItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
            params: GetDocumentUsecaseReqParams(
                pageType: EnumSendPageType.reminder,
                type: isInvoice()
                    ? EnumDocumentType.invoice
                    : EnumDocumentType.estimate,
                id: widget.invoiceEntity.id ?? "")));
      },
      child: headerActionCell(context,
          actionButtonType: InvoiceActionButtonType.reminder),
    );
  }

  void _editInvoiceEntity() {
    debugPrint("Type: ${isInvoice()}");

    isIgnoreBlocStates = true;
    AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
        invoiceDetailResEntity: invoiceDetailResEntity,
        invoiceEntity: invoiceEntity,
        estimateTitle: widget.estimateTitle,
        type: isInvoice()
            ? EnumNewInvoiceEstimateType.editInvoice
            : EnumNewInvoiceEstimateType.editEstimate,
        startObserveBlocBack: () {
          isIgnoreBlocStates = false;
        },
        refreshCallBack: () {
          isIgnoreBlocStates = false;
          _loadData();
        }));
  }

  Widget editItem(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _editInvoiceEntity();
        },
        child: headerActionCell(context,
            actionButtonType: InvoiceActionButtonType.edit));
  }

  void _getPdfContent() {
    AutoRouter.of(context).push(PdfviewerPageRoute(
        enumPageType:
            isInvoice() ? EnumDocumentType.invoice : EnumDocumentType.estimate,
        id: invoiceEntity?.id ?? "",
        isPrint: false));
  }

  void _getPrintPdfContent() {
    AutoRouter.of(context).push(PdfviewerPageRoute(
        enumPageType:
            isInvoice() ? EnumDocumentType.invoice : EnumDocumentType.estimate,
        id: invoiceEntity?.id ?? "",
        isPrint: true));
  }

  void _openPaymentPage() {
    if (invoiceDetailResEntity?.payments != null &&
        invoiceDetailResEntity!.payments!.isNotEmpty) {
      isIgnoreBlocStates = true;
      AutoRouter.of(context).push(PaymentListPageRoute(
          refreshPage: () {
            isIgnoreBlocStates = false;
            _loadData();
          },
          emailList: invoiceEntity?.emailtoClientstaff ?? [],
          payments: invoiceDetailResEntity!.payments!,
          balanceAmount: invoiceEntity?.balance ?? "",
          invoiceId: invoiceEntity?.id ?? ""));
    } else {
      _showAddPaymentPage(null);
    }
  }

  bool isPartial() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "partial") {
      return true;
    }
    return false;
  }

  bool isOverdue() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "overdue") {
      return true;
    }
    return false;
  }

  bool isVoid() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "void") {
      return true;
    }
    return false;
  }

  bool isPaid() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "paid") {
      return true;
    }
    return false;
  }

  bool isOverDue() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "overdue") {
      return true;
    }
    return false;
  }

  bool isInvoiced() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "invoiced") {
      return true;
    }
    return false;
  }

  bool isSent() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "sent") {
      return true;
    }
    return false;
  }

  bool isDraft() {
    final status = invoiceEntity?.status ?? "";
    if (status.isNotEmpty && status.toLowerCase() == "draft") {
      return true;
    }
    return false;
  }

  bool isInvoice() {
    if (widget.type == EnumNewInvoiceEstimateType.duplicateInvoice ||
        widget.type == EnumNewInvoiceEstimateType.invoice ||
        widget.type == EnumNewInvoiceEstimateType.editInvoice ||
        widget.type == EnumNewInvoiceEstimateType.convertEstimateToInvoice) {
      return true;
    }
    return false;
  }

  void _convertToInvoice() {
    isIgnoreBlocStates = true;
    AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
        invoiceDetailResEntity: invoiceDetailResEntity,
        invoiceEntity: invoiceEntity,
        type: EnumNewInvoiceEstimateType.convertEstimateToInvoice,
        startObserveBlocBack: () {
          isIgnoreBlocStates = false;
        },
        refreshCallBack: () {
          isIgnoreBlocStates = false;
        }));
  }

  void showEstimateViewMore() {
    showAdaptiveActionSheet(
        useRootNavigator: true,
        androidBorderRadius: 30,
        isDismissible: true,
        context: context,
        actions: [
          if (invoiceEntity?.status?.toLowerCase() == "sent" ||
              invoiceEntity?.status?.toLowerCase() == "invoiced" ||
              invoiceEntity?.status?.toLowerCase() == "expired")
            BottomSheetAction(
                title: Text(
                  "Send Estimate",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();
                  _onTapSendDoc();
                }),
          if (invoiceEntity?.status?.toLowerCase() == "draft")
            BottomSheetAction(
                title: Text(
                  "Mark as Sent",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  dismissPopup(context);
                  showAlert();
                }),
          if (invoiceEntity?.status?.toLowerCase() != "invoiced")
            BottomSheetAction(
                title: Text(
                  "Print PDF",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();
                  _getPrintPdfContent();
                }),
          if (widget.type == EnumNewInvoiceEstimateType.estimate &&
              invoiceEntity?.status?.toLowerCase() == "draft")
            BottomSheetAction(
                title: Text(
                  "Convert to Invoice",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  isIgnoreBlocStates = true;
                  AutoRouter.of(context).maybePop();
                  _convertToInvoice();
                }),
          BottomSheetAction(
              title: Text(
                "Duplicate",
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (context) {
                isIgnoreBlocStates = true;
                AutoRouter.of(context).maybePop();
                AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
                    invoiceDetailResEntity: invoiceDetailResEntity,
                    invoiceEntity: invoiceEntity,
                    type: isInvoice()
                        ? EnumNewInvoiceEstimateType.duplicateInvoice
                        : EnumNewInvoiceEstimateType.duplicateEstimate,
                    startObserveBlocBack: () {
                      isIgnoreBlocStates = false;
                    },
                    refreshCallBack: () {
                      isIgnoreBlocStates = false;
                    }));
              }),
          BottomSheetAction(
              title: Text(
                "View History",
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
                openHistoryList();
              }),
          BottomSheetAction(
              title: Text(
                "Delete",
                style: AppFonts.regularStyle(color: AppPallete.red, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
                _showDeleteAlert();
              }),
        ],
        cancelAction: CancelAction(
            title: Text(
          'Cancel',
          style: AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16),
        ))); //);
  }

  void _onTapSendDoc() {
    AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
        params: GetDocumentUsecaseReqParams(
            pageType: EnumSendPageType.send,
            type: isInvoice()
                ? EnumDocumentType.invoice
                : EnumDocumentType.estimate,
            id: widget.invoiceEntity.id ?? "")));
  }

  void showInvoiceViewMore() {
    showAdaptiveActionSheet(
        useRootNavigator: true,
        androidBorderRadius: 30,
        isDismissible: true,
        context: context,
        actions: [
          if (isSent() || isPartial() || isPaid() || isOverdue())
            BottomSheetAction(
                title: Text(
                  "Send Invoice",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();

                  AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
                      params: GetDocumentUsecaseReqParams(
                          pageType: EnumSendPageType.send,
                          type: isInvoice()
                              ? EnumDocumentType.invoice
                              : EnumDocumentType.estimate,
                          id: widget.invoiceEntity.id ?? "")));
                }),
          if (isVoid() || isPaid())
            BottomSheetAction(
                title: Text(
                  "Payments",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();
                  _openPaymentPage();
                }),
          if (isDraft())
            BottomSheetAction(
                title: Text(
                  "Mark as Sent",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  dismissPopup(context);
                  showAlert();
                }),
          if (isSent() || isPartial() || isOverDue())
            BottomSheetAction(
                title: Text(
                  "View PDF",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();
                  _getPdfContent();
                }),
          if (!isPaid())
            BottomSheetAction(
                title: Text(
                  "Print PDF",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();
                  _getPrintPdfContent();
                }),
          BottomSheetAction(
              title: Text(
                "Duplicate",
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
                isIgnoreBlocStates = true;
                AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
                    invoiceDetailResEntity: invoiceDetailResEntity,
                    invoiceEntity: invoiceEntity,
                    type: EnumNewInvoiceEstimateType.duplicateInvoice,
                    startObserveBlocBack: () {
                      isIgnoreBlocStates = false;
                    },
                    refreshCallBack: () {
                      isIgnoreBlocStates = false;
                    }));
              }),
          if (isSent() || isPartial() || isOverDue())
            BottomSheetAction(
                title: Text(
                  "Void",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();
                  _showVoidAlert();
                }),
          BottomSheetAction(
              title: Text(
                "View History",
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
                openHistoryList();
              }),
          BottomSheetAction(
              title: Text(
                "Delete",
                style: AppFonts.regularStyle(color: AppPallete.red, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
                _showDeleteAlert();
              }),
        ],
        cancelAction: CancelAction(
            title: Text(
          'Cancel',
          style: AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16),
        ))); //);
  }

  void showDraftSheet() {
    showAdaptiveActionSheet(
        useRootNavigator: true,
        androidBorderRadius: 30,
        isDismissible: true,
        context: context,
        actions: [
          if (invoiceEntity?.status?.toLowerCase() == "sent")
            BottomSheetAction(
                title: Text(
                  "Send Estimate",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();

                  AutoRouter.of(context).push(SendInvoiceEstimatePageRoute(
                      params: GetDocumentUsecaseReqParams(
                          pageType: EnumSendPageType.send,
                          type: EnumDocumentType.estimate,
                          id: widget.invoiceEntity.id ?? "")));
                }),
          if (invoiceEntity?.status?.toLowerCase() == "draft")
            BottomSheetAction(
                title: Text(
                  "Mark as Sent",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  dismissPopup(context);
                  showAlert();
                }),
          if (widget.type == EnumNewInvoiceEstimateType.estimate &&
              invoiceEntity?.status?.toLowerCase() == "draft")
            BottomSheetAction(
                title: Text(
                  "Convert to Invoice",
                  style: AppFonts.regularStyle(
                      color: AppPallete.blueColor, size: 16),
                ),
                onPressed: (context) {
                  AutoRouter.of(context).maybePop();
                  AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
                      invoiceDetailResEntity: invoiceDetailResEntity,
                      invoiceEntity: invoiceEntity,
                      type: EnumNewInvoiceEstimateType.convertEstimateToInvoice,
                      startObserveBlocBack: () {
                        isIgnoreBlocStates = false;
                      },
                      refreshCallBack: () {
                        isIgnoreBlocStates = false;
                      }));
                }),
          BottomSheetAction(
              title: Text(
                "Print PDF",
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
              }),
          BottomSheetAction(
              title: Text(
                "Duplicate",
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
                AutoRouter.of(context).push(AddNewInvoiceEstimatePageRoute(
                    invoiceDetailResEntity: invoiceDetailResEntity,
                    invoiceEntity: invoiceEntity,
                    type: EnumNewInvoiceEstimateType.duplicateEstimate,
                    startObserveBlocBack: () {},
                    refreshCallBack: () {}));
              }),
          BottomSheetAction(
              title: Text(
                "View History",
                style: AppFonts.regularStyle(
                    color: AppPallete.blueColor, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
                openHistoryList();
              }),
          BottomSheetAction(
              title: Text(
                "Delete",
                style: AppFonts.regularStyle(color: AppPallete.red, size: 16),
              ),
              onPressed: (context) {
                AutoRouter.of(context).maybePop();
              }),
        ],
        cancelAction: CancelAction(
            title: Text(
          'Cancel',
          style: AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16),
        ))); //);
  }

  void openHistoryList() {
    if (invoiceDetailResEntity?.history != null &&
        invoiceDetailResEntity!.history!.isNotEmpty) {
      AutoRouter.of(context).push(InvoiceHistoryListRoute(
          historyList: invoiceDetailResEntity!.history!));
    }
  }

  Widget headerActionCell(BuildContext context,
      {required InvoiceActionButtonType actionButtonType}) {
    return Container(
      decoration: const BoxDecoration(color: AppPallete.lightBlueColor),
      child: Column(
        children: [
          SizedBox(
            width: 33,
            height: 33,
            child: Image.asset(actionButtonType.imageName),
          ),
          Text(
            actionButtonType.name,
            style: AppFonts.regularStyle(size: 14, color: AppPallete.blueColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    if (indexPath.section == 0) {
      return headerCell(context);
    } else if (indexPath.section == 1) {
      if (invoiceEntity != null) {
        return InvoiceDetailsInfoWidget(
          invoiceEntity: invoiceEntity!,
          type: widget.type,
          estimateTitle: widget.estimateTitle,
        );
      }
      return Container(
        color: AppPallete.white,
        child: Center(
          child: Text(
            "No Data",
            style: AppFonts.regularStyle(),
          ),
        ),
      );
    } else if (indexPath.section == 2) {
      final items = invoiceEntity?.items;
      if (items != null && items.length > indexPath.item) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ItemDetailsCardWidget(
            invoiceItemEntity: items[indexPath.item],
            currencySymbol: invoiceEntity!.decodedCurrencySymbol,
          ),
        );
      }
      return const SizedBox();
    } else if (isPaymentSectionVisible() && indexPath.section == 3) {
      if (invoiceDetailResEntity?.payments != null &&
          invoiceDetailResEntity!.payments!.isNotEmpty &&
          invoiceDetailResEntity?.payments?[indexPath.item] != null) {
        final paymentItem = invoiceDetailResEntity!.payments![indexPath.item];
        return GestureDetector(
          onTap: () {
            _showAddPaymentPage(paymentItem);
          },
          child: SwipeActionCell(
            key: ObjectKey(paymentItem),
            trailingActions: [
              SwipeAction(
                  closeOnTap: true,
                  style: AppFonts.regularStyle(color: AppPallete.white),
                  title: "Delete",
                  onTap: (CompletionHandler handler) async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AppAlertWidget(
                            title: "Delete Payment",
                            message:
                                "Are you sure you want to delete this payment?",
                            onTapDelete: () {
                              debugPrint("on tap delete item");
                              AutoRouter.of(context).maybePop();
                              context.read<InvoiceBloc>().add(
                                  DeletePaymentEvent(
                                      params: DeletePaymentUsecaseReqParams(
                                          id: paymentItem.id ?? "")));
                            },
                          );
                        });
                  },
                  color: Colors.red),
            ],
            child: PaymentItemWidget(
              paymentEntity: paymentItem,
            ),
          ),
        );
      }
      return Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Text(
          "This invoice does not have any payments.",
          style: AppFonts.regularStyle(size: 12),
        ),
      ));
    } else if (indexPath.section ==
            (isPaymentSectionVisible() == true ? 4 : 3) &&
        invoiceDetailResEntity?.history != null &&
        invoiceDetailResEntity!.history!.isNotEmpty) {
      return HistoryItemWidget(
        historyEntity: invoiceDetailResEntity!.history![indexPath.item],
        showViewHstory: true,
        onPressViewHistory: () {
          openHistoryList();
        },
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  int numberOfItems(int section) {
    if (invoiceEntity == null) {
      return 0;
    }
    if (section == 2) {
      return invoiceEntity?.items?.length ?? 0;
    }
    //else if (isPaymentSectionVisible() && indexPath.section == 3)
    if (isPaymentSectionVisible() && section == 3) {
      if (invoiceDetailResEntity?.payments != null &&
          invoiceDetailResEntity!.payments!.isNotEmpty) {
        return invoiceDetailResEntity?.payments?.length ?? 0;
      } else {
        return 1;
      }
    }
    if (section == (isPaymentSectionVisible() == true ? 4 : 3)) {
      final historyLength = invoiceDetailResEntity?.history?.length ?? 0;
      if (historyLength > 0) {
        return 1;
      }
      return 0;
    }
    return 1;
  }

  bool isPaymentSectionVisible() {
    if (widget.type == EnumNewInvoiceEstimateType.invoice ||
        widget.type == EnumNewInvoiceEstimateType.convertEstimateToInvoice ||
        widget.type == EnumNewInvoiceEstimateType.editInvoice) {
      final status = invoiceEntity?.status ?? "";
      return status.toLowerCase() != "draft";
    }
    return false;
  }

  @override
  int numberOfSections() {
    if (invoiceDetailResEntity == null) {
      return 0;
    }
    int count = 4;
    if (isPaymentSectionVisible()) {
      count += 1;
    }
    debugPrint("Total Sections: $count");
    return count;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    if (section == 2) {
      return true;
    }
    if (isPaymentSectionVisible() && section == 3) {
      return true;
    }
    if (section == (isPaymentSectionVisible() == true ? 4 : 3)) {
      if (invoiceDetailResEntity?.history != null) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldExistSectionFooter(int section) {
    if (section == 2 &&
        invoiceDetailResEntity != null &&
        invoiceEntity != null) {
      return true;
    }
    return false;
  }

  @override
  Widget getSectionFooter(BuildContext context, int section) {
    if (invoiceDetailResEntity != null && invoiceEntity != null) {
      return ItemsTaxAmountDetailsWidget(
        invoiceDetailResEntity: invoiceDetailResEntity!,
        invoiceEntity: invoiceEntity!,
        isInvoice: isInvoice(),
      );
    }
    return const SizedBox();
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    if (section == 2) {
      return const ItemDetailsAmountSectionWidget();
    } else if (isPaymentSectionVisible() && section == 3) {
      return SectionHeaderWidget(
        title: "Payments",
        haveLeadingButton: (isPaid() || isDraft() || isVoid()) ? false : true,
        onTapLeadingButton: () {
          _showAddPaymentPage(null);
        },
      );
    } else if (section == (isPaymentSectionVisible() == true ? 4 : 3)) {
      return const SectionHeaderWidget(title: "History");
    } else {
      return const SizedBox();
    }
  }

  void _showAddPaymentPage(PaymentEntity? paymentEntity) {
    isIgnoreBlocStates = true;
    AutoRouter.of(context).push(AddPaymentPageRoute(
        balanceAmount: invoiceEntity?.balance ?? "",
        id: invoiceEntity?.id ?? "",
        paymentEntity: paymentEntity,
        startObserveBlocBack: () {
          isIgnoreBlocStates = false;
        },
        emailList: invoiceEntity?.emailtoClientstaff ?? [],
        refreshPage: () {
          isIgnoreBlocStates = false;
          callRefresh = true;
          _loadData();
        }));
  }

  void dismissPopup(context) {
    AutoRouter.of(context).maybePop();
  }

  void _showVoidAlert() {
    Timer(const Duration(milliseconds: 500), () {
      _showVoidAlertDialog();
    });
  }

  void _showVoidAlertDialog() {
    showDialog(
        context: mainContext!,
        builder: (context) {
          return AppAlertWidget(
            title: "Void Invoice",
            message: "Are you sure you want to void this invoice?",
            onTapDelete: () {
              dismissPopup(context);
              _voidInvoice();
            },
            alertType: EnumAppAlertType.voidInvoice,
          );
        });
  }

  void _showUnVoidAlert() {
    Timer(const Duration(milliseconds: 500), () {
      _showUnVoidAlertDialog();
    });
  }

  void _showUnVoidAlertDialog() {
    showDialog(
        context: mainContext!,
        builder: (context) {
          return AppAlertWidget(
            title: "Unvoid Invoice",
            message: "Are you sure you want to unvoid this invoice?",
            onTapDelete: () {
              dismissPopup(context);
              _unVoidInvoice();
            },
            alertType: EnumAppAlertType.unVoid,
          );
        });
  }

  void showAlert() {
    Timer(const Duration(milliseconds: 500), () {
      showMarkAsSentAlert();
    });
  }

  void showMarkAsSentAlert() {
    showDialog(
        context: mainContext!,
        builder: (context) {
          return AppAlertWidget(
            title: "Mark as Sent",
            message:
                "This ${isInvoice() ? "invoice" : "estimate"} will be marked as sent and due, without actually sending it to your client. Confirm?",
            onTapDelete: () {
              debugPrint("on tap mark as send item");
              dismissPopup(context);
              _setMarkAsSent();
            },
            alertType: EnumAppAlertType.ok,
          );
        });
  }

  void _showDeleteAlert() {
    Timer(const Duration(milliseconds: 500), () {
      _showDeleteDialogAlert();
    });
  }

  void _showDeleteDialogAlert() {
    showDialog(
        context: mainContext!,
        builder: (context) {
          return AppAlertWidget(
            title: isInvoice() ? "Delete Invoice" : "Delete Estimate",
            message:
                "Are you sure you want to delete this ${isInvoice() ? "invoice" : "estimate"}?",
            onTapDelete: () {
              dismissPopup(context);
              _deleteInvoice();
            },
            alertType: EnumAppAlertType.delete,
          );
        });
  }

  void _setMarkAsSent() {
    if (invoiceEntity != null && invoiceEntity!.id != null) {
      context.read<InvoiceBloc>().add(InvoiceMarkAsSendEvent(
              params: InvoiceMarkassendReqParms(
            id: invoiceEntity?.id ?? "",
            type: widget.type,
          )));
    }
  }

  void _deleteInvoice() {
    if (invoiceEntity != null && invoiceEntity!.id != null) {
      context.read<InvoiceBloc>().add(InvoiceDeleteEvent(
              params: InvoiceDeleteReqParms(
            id: invoiceEntity?.id ?? "",
            type: isInvoice()
                ? EnumDocumentType.invoice
                : EnumDocumentType.estimate,
          )));
    }
  }

  void _voidInvoice() {
    if (invoiceEntity != null && invoiceEntity!.id != null) {
      context.read<InvoiceBloc>().add(InvoiceVoidEvent(
              params: InvoiceVoidReqParms(
            id: invoiceEntity?.id ?? "",
          )));
    }
  }

  void _unVoidInvoice() {
    if (invoiceEntity != null && invoiceEntity!.id != null) {
      context.read<InvoiceBloc>().add(InvoiceUnVoidEvent(
              params: InvoiceUnVoidReqParms(
            id: invoiceEntity?.id ?? "",
          )));
    }
  }
}
