import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/integrations/domain/usecase/online_payment_details_usecase.dart';
import 'package:billbooks_app/features/integrations/presentation/bloc/online_payments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/utils/show_toast.dart';
import '../../../core/widgets/loading_page.dart';
import '../../../core/widgets/new_inputview_widget.dart';
import '../../../core/widgets/online_payment_header_widget.dart';
import '../domain/entity/online_payment_details_entity.dart';

@RoutePage()
class CheckoutPage extends StatefulWidget {
  final OnlinePaymentsEntity? onlinePaymentsEntity;
  final Function() refreshList;

  const CheckoutPage(
      {super.key, this.onlinePaymentsEntity, required this.refreshList});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController accountController = TextEditingController();
  TextEditingController secretWordController = TextEditingController();

  @override
  void initState() {
    _populateData();
    super.initState();
  }

  void _populateData() {
    accountController.text = widget.onlinePaymentsEntity?.pg2CoId ?? "";
    secretWordController.text = widget.onlinePaymentsEntity?.pg2CoSecret ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: const Text("2Checkout"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {
                context.read<OnlinePaymentsBloc>().add(
                    UpdateCheckoutDetailsEvents(
                        checkoutUseCaseUsecaseReqParams:
                            CheckoutUseCaseUsecaseReqParams(
                                accountId: accountController.text,
                                secret: secretWordController.text)));
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: BlocConsumer<OnlinePaymentsBloc, OnlinePaymentsState>(
        listener: (context, state) {
          if (state is UpdateCheckoutDeatilsSuccessState) {
            showToastification(
                context,
                "Successfully updated checkout details.",
                ToastificationType.success);
            widget.refreshList();
            AutoRouter.of(context).maybePop();
          }
          if (state is UpdateCheckoutDeatilsErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is UpdateCheckoutDeatilsLoadingState) {
            return const LoadingPage(title: "Updating checkout details...");
          }

          return SingleChildScrollView(
            child: Container(
              color: AppPallete.kF2F2F2,
              child: Column(
                children: [
                  AppConstants.sizeBoxHeight10,
                  Container(
                      padding: AppConstants.horizotal16,
                      color: AppPallete.white,
                      child: const OnlinePaymentHeaderWidget(
                          title: "Transaction charges:")),
                  AppConstants.sizeBoxHeight10,
                  NewInputViewWidget(
                      title: "2CO Account #",
                      hintText: "2CO Account #",
                      isRequired: false,
                      controller: accountController),
                  NewInputViewWidget(
                      title: "Secret Word",
                      hintText: "Secret Word",
                      isRequired: false,
                      inputAction: TextInputAction.done,
                      controller: secretWordController),
                  Padding(
                    padding: AppConstants.horizontalVerticalPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Configure your 2Checkout Account",
                          style: AppFonts.regularStyle(),
                        ),
                        AppConstants.sizeBoxHeight15,
                        const CheckoutBulletWidget(
                          title: "Login to your 2Checkout account",
                        ),
                        AppConstants.sepSizeBox5,
                        const CheckoutBulletWidget(
                            title:
                                "Head to the ‘ACCOUNT’ tab and then click ‘SITE MANAGEMENT’."),
                        AppConstants.sepSizeBox5,
                        const CheckoutBulletWidget(
                            title:
                                "Ensure you have selected ‘Off’ fir Demo Settings."),
                        AppConstants.sepSizeBox5,
                        const CheckoutBulletWidget(
                            title:
                                "Choose the ‘Direct Return (Our URL)’ option under Direct Return."),
                        AppConstants.sepSizeBox5,
                        const CheckoutBulletWidget(
                            title:
                                "Enter the below URL in Approved URL field.  https://mybillbooks.com/service/ipn/2checkout"),
                        AppConstants.sepSizeBox5,
                        const CheckoutBulletWidget(
                            title: "Click on ‘Save Changes’ and you are done.")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CheckoutBulletWidget extends StatelessWidget {
  final String title;
  const CheckoutBulletWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "• ",
          style: AppFonts.regularStyle(color: AppPallete.k666666),
        ),
        Expanded(
          child: Text(
            title,
            style: AppFonts.regularStyle(color: AppPallete.k666666, size: 14),
          ),
        )
      ],
    );
  }
}
