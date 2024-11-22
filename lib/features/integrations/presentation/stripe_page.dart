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
class StripePage extends StatefulWidget {
  final OnlinePaymentsEntity? onlinePaymentsEntity;
  final Function() refreshList;

  const StripePage(
      {super.key, this.onlinePaymentsEntity, required this.refreshList});

  @override
  State<StripePage> createState() => _StripePageState();
}

class _StripePageState extends State<StripePage> {
  TextEditingController secretKeyController = TextEditingController();
  TextEditingController publishedKeyController = TextEditingController();

  @override
  void initState() {
    _populateData();
    super.initState();
  }

  void _populateData() {
    debugPrint(widget.onlinePaymentsEntity?.pgStripeId);
    secretKeyController.text = widget.onlinePaymentsEntity?.pgStripeId ?? "";
    publishedKeyController.text =
        widget.onlinePaymentsEntity?.pgStripePublishablekey ?? "";
  }

  void _updateStripeDetails() {
    context.read<OnlinePaymentsBloc>().add(UpdateStripeDetailsEvents(
        stripeUseCaseReqParams: StripeUseCaseReqParams(
            id: secretKeyController.text,
            publishableKey: publishedKeyController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {
                _updateStripeDetails();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: BlocConsumer<OnlinePaymentsBloc, OnlinePaymentsState>(
        listener: (context, state) {
          if (state is UpdateStripeDeatilsSuccessState) {
            showToastification(context, "Successfully updated stripe details.",
                ToastificationType.success);
            widget.refreshList();
            AutoRouter.of(context).maybePop();
          }
          if (state is UpdateStripeDeatilsErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is UpdateStripeDeatilsLoadingState) {
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
                    title: "Secret Key",
                    hintText: "Secret Key",
                    isRequired: false,
                    controller: secretKeyController),
                NewInputViewWidget(
                    title: "Published Key",
                    hintText: "Published Key",
                    isRequired: false,
                    inputAction: TextInputAction.done,
                    controller: publishedKeyController),
              ],
            ),
          );
        },
      ),
    );
  }
}
