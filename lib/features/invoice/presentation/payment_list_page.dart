import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/list_empty_page.dart';
import 'package:billbooks_app/features/invoice/domain/usecase/payment_list_usecase.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/payment_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:toastification/toastification.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/show_toast.dart';
import '../../../core/widgets/app_alert_widget.dart';
import '../../../core/widgets/loading_page.dart';
import '../../../router/app_router.dart';
import '../domain/entities/invoice_details_entity.dart';
import '../domain/usecase/delete_payment_usecase.dart';
import 'bloc/invoice_bloc.dart';

@RoutePage()
class PaymentListPage extends StatefulWidget {
  final String invoiceId;
  final String balanceAmount;
  final List<PaymentEntity> payments;
  final Function() refreshPage;
  final List<EmailtoMystaffEntity> emailList;
  const PaymentListPage({
    super.key,
    required this.refreshPage,
    required this.payments,
    required this.balanceAmount,
    required this.invoiceId,
    required this.emailList,
  });

  @override
  State<PaymentListPage> createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  List<PaymentEntity> paymentList = [];
  String balance = "";
  String id = "";
  String? deletingPaymentId;
  bool refreshPreviousPage = false;

  @override
  void initState() {
    _populateData();
    super.initState();
  }

  void _getPaymentList() {
    context
        .read<InvoiceBloc>()
        .add(GetPaymentListEvent(params: PaymentListReqParams(id: id)));
  }

  void _populateData() {
    paymentList = widget.payments;
    balance = widget.balanceAmount;
    id = widget.invoiceId;
  }

  void showAddPaymentPage(PaymentEntity? paymentEntity) {
    AutoRouter.of(context).push(AddPaymentPageRoute(
        balanceAmount: balance,
        id: id,
        paymentEntity: paymentEntity,
        emailList: widget.emailList,
        startObserveBlocBack: () {},
        refreshPage: () {
          debugPrint("refreshPage called in list page");
          _getPaymentList();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments"),
        bottom: AppConstants.getAppBarDivider,
        leading: IconButton(
            onPressed: () {
              if (refreshPreviousPage) {
                widget.refreshPage();
              }
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
        actions: [
          IconButton(
              onPressed: () {
                showAddPaymentPage(null);
              },
              icon: const Icon(
                Icons.add,
                color: AppPallete.blueColor,
              ))
        ],
      ),
      body: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is PaymentListSuccessState) {
            debugPrint("PaymentListSuccessState");
            paymentList = state.paymentListMainResEntity.data?.payments ?? [];
            refreshPreviousPage = true;
            setState(() {});
          }
          if (state is DeletePaymentSuccessState) {
            showToastification(
                context,
                state.deletePaymentMethodMainResEntity.data?.message ??
                    "Successfully deleted payment.",
                ToastificationType.success);
            balance =
                (state.deletePaymentMethodMainResEntity.data?.balance ?? 0)
                    .toString();
            refreshPreviousPage = true;
            if (deletingPaymentId != null) {
              final index = paymentList.indexWhere((returnedItem) {
                return returnedItem.id == deletingPaymentId;
              });
              if (index >= 0) {
                paymentList.removeAt(index);
                setState(() {});
              }
            }
          }
          if (state is DeletePaymentErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is PaymentListErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is PaymentListLoadingState) {
            return const LoadingPage(title: "Loading payments...");
          }
          if (state is DeletePaymentLoadingState) {
            return const LoadingPage(title: "Deleting payment...");
          }
          if (paymentList.isEmpty) {
            return ListEmptyPage(
                buttonTitle: "Add payment",
                noDataText: "No Payment Records",
                noDataSubtitle: "",
                iconName: Icons.attach_money,
                callBack: () {
                  showAddPaymentPage(null);
                });
          }
          return ListView.builder(
              itemCount: paymentList.length,
              itemBuilder: (builder, index) {
                PaymentEntity item = paymentList[index];
                return SwipeActionCell(
                    key: ObjectKey(item),
                    trailingActions: [
                      SwipeAction(
                          closeOnTap: true,
                          style: AppFonts.regularStyle(color: AppPallete.white),
                          title: "Delete",
                          onTap: (CompletionHandler handler) async {
                            await handler(false);
                            showAlert(item.id ?? "");
                          },
                          color: Colors.red),
                    ],
                    child: GestureDetector(
                        onTap: () {
                          showAddPaymentPage(item);
                        },
                        child: PaymentItemWidget(paymentEntity: item)));
              });
        },
      ),
    );
  }

  showAlert(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AppAlertWidget(
            title: "Delete Payment",
            message: "Are you sure you want to delete this payment?",
            onTapDelete: () {
              AutoRouter.of(context).maybePop();
              deletingPaymentId = id;
              context.read<InvoiceBloc>().add(DeletePaymentEvent(
                  params: DeletePaymentUsecaseReqParams(id: id)));
            },
          );
        });
  }
}
