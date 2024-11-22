import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/online_payment_header_widget.dart';
import 'package:billbooks_app/features/integrations/presentation/bloc/online_payments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../domain/entity/online_payment_details_entity.dart';
import '../domain/usecase/online_payment_details_usecase.dart';

@RoutePage()
class PaypalPage extends StatefulWidget {
  final OnlinePaymentsEntity? onlinePaymentsEntity;
  final Function() refreshList;

  const PaypalPage(
      {super.key, this.onlinePaymentsEntity, required this.refreshList});

  @override
  State<PaypalPage> createState() => _PaypalPageState();
}

class _PaypalPageState extends State<PaypalPage> {
  TextEditingController paypalController = TextEditingController();

  @override
  void initState() {
    populatedata();
    super.initState();
  }

  void populatedata() {
    paypalController.text = widget.onlinePaymentsEntity?.pgPaypalId ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PayPal"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {
                final params =
                    PaypalUsecaseReqParams(paypalid: paypalController.text);
                context.read<OnlinePaymentsBloc>().add(
                    UpDatePayPalDetailsEvents(paypalUsecaseReqParams: params));
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: BlocConsumer<OnlinePaymentsBloc, OnlinePaymentsState>(
        listener: (context, state) {
          if (state is UpdatePaypalDeatilsSuccessState) {
            showToastification(context, "Successfully updated paypal details.",
                ToastificationType.success);
            widget.refreshList();
            AutoRouter.of(context).maybePop();
          }
          if (state is UpdatePaypalDeatilsErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is UpdatePaypalDeatilsLoadingState) {
            return const LoadingPage(title: "Updating paypal deatils...");
          }
          return Container(
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
                    title: "Paypal Email",
                    hintText: "Paypal Email",
                    isRequired: false,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.done,
                    controller: paypalController),
              ],
            ),
          );
        },
      ),
    );
  }
}
