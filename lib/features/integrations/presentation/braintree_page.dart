import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/integrations/presentation/bloc/online_payments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';
import '../../../core/utils/show_toast.dart';
import '../../../core/widgets/new_inputview_widget.dart';
import '../../../core/widgets/online_payment_header_widget.dart';
import '../domain/entity/online_payment_details_entity.dart';
import '../domain/usecase/online_payment_details_usecase.dart';

@RoutePage()
class BraintreePage extends StatefulWidget {
  final OnlinePaymentsEntity? onlinePaymentsEntity;
  final Function() refreshList;

  const BraintreePage(
      {super.key, this.onlinePaymentsEntity, required this.refreshList});

  @override
  State<BraintreePage> createState() => _BraintreePageState();
}

class _BraintreePageState extends State<BraintreePage> {
  TextEditingController merchantIDController = TextEditingController();
  TextEditingController publicKeyController = TextEditingController();
  TextEditingController privateKeyCntroller = TextEditingController();

  @override
  void initState() {
    populateData();
    super.initState();
  }

  void populateData() {
    merchantIDController.text =
        widget.onlinePaymentsEntity?.pgBraintreeId ?? "";
    publicKeyController.text =
        widget.onlinePaymentsEntity?.pgBraintreePublickey ?? "";
    privateKeyCntroller.text =
        widget.onlinePaymentsEntity?.pgBraintreePrivatekey ?? "";
  }

  void _updateBraintreeDetails() {
    context.read<OnlinePaymentsBloc>().add(UpDateBraintreeDetailsEvents(
        brainTreeUseCaseUsecaseReqParams: BrainTreeUseCaseUsecaseReqParams(
            merchantId: merchantIDController.text,
            publickey: publicKeyController.text,
            privateKey: privateKeyCntroller.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Braintree"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {
                _updateBraintreeDetails();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: BlocConsumer<OnlinePaymentsBloc, OnlinePaymentsState>(
        listener: (context, state) {
          if (state is UpdateBraintreeDeatilsSuccessState) {
            showToastification(
                context,
                "Successfully updated braintree details.",
                ToastificationType.success);
            widget.refreshList();
            AutoRouter.of(context).maybePop();
          }
          if (state is UpdateBraintreeDeatilsErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is UpdateBraintreeDeatilsLoadingState) {
            return const LoadingPage(title: "Updating braintree details...");
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
                    title: "Merchant ID",
                    hintText: "Merchant ID",
                    isRequired: false,
                    controller: merchantIDController),
                NewInputViewWidget(
                    title: "Public Key",
                    hintText: "Public Key",
                    isRequired: false,
                    controller: publicKeyController),
                NewInputViewWidget(
                    title: "Private Key",
                    hintText: "Private Key",
                    isRequired: false,
                    inputAction: TextInputAction.done,
                    controller: privateKeyCntroller),
              ],
            ),
          );
        },
      ),
    );
  }
}
