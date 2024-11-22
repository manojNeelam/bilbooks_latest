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
class AuthorizePage extends StatefulWidget {
  final Function() refreshList;
  final OnlinePaymentsEntity? onlinePaymentsEntity;
  const AuthorizePage(
      {super.key, this.onlinePaymentsEntity, required this.refreshList});

  @override
  State<AuthorizePage> createState() => _AuthorizePageState();
}

class _AuthorizePageState extends State<AuthorizePage> {
  TextEditingController apiLoginIDController = TextEditingController();
  TextEditingController keyController = TextEditingController();

  @override
  void initState() {
    populateData();
    super.initState();
  }

  void populateData() {
    apiLoginIDController.text =
        widget.onlinePaymentsEntity?.pgAuthorizeId ?? "";
    keyController.text = widget.onlinePaymentsEntity?.pgAuthorizeTranskey ?? "";
  }

  void _updateAuthorizeDetails() {
    context.read<OnlinePaymentsBloc>().add(UpDateAuthoriseDetailsEvents(
        authorizeUsecaseReqParams: AuthorizeUsecaseReqParams(
            authoriseId: apiLoginIDController.text,
            authriseTransactionKey: keyController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authorize.Net"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {
                _updateAuthorizeDetails();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: BlocConsumer<OnlinePaymentsBloc, OnlinePaymentsState>(
        listener: (context, state) {
          if (state is UpdateAuthoriseDeatilsSuccessState) {
            showToastification(
                context,
                "Successfully updated authorize details.",
                ToastificationType.success);
            widget.refreshList();
            AutoRouter.of(context).maybePop();
          }
          if (state is UpdateAuthoriseDeatilsErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
        },
        builder: (context, state) {
          if (state is UpdateAuthoriseDeatilsLoadingState) {
            return const LoadingPage(title: "Updating authorize details...");
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
                    title: "API Login ID",
                    hintText: "API Login ID",
                    isRequired: false,
                    controller: apiLoginIDController),
                NewInputViewWidget(
                    title: "Transaction Key",
                    hintText: "Transaction Key",
                    isRequired: false,
                    inputAction: TextInputAction.done,
                    controller: keyController),
              ],
            ),
          );
        },
      ),
    );
  }
}
