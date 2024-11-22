import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/widgets/app_alert_widget.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/taxes/presentation/bloc/tax_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

@RoutePage()
class AddTaxPage extends StatefulWidget {
  final Function()? refreshPage;
  final TaxEntity? taxEntity;
  const AddTaxPage({super.key, this.taxEntity, this.refreshPage});

  @override
  State<AddTaxPage> createState() => _AddTaxPageState();
}

class _AddTaxPageState extends State<AddTaxPage> {
  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxRateController = TextEditingController();
  bool isValidInput = false;

  bool isEdit() {
    return widget.taxEntity != null;
  }

  @override
  void initState() {
    if (isEdit()) {
      final name = widget.taxEntity?.name ?? "";
      taxNameController.text = name;
      taxRateController.text = "${widget.taxEntity?.rate ?? 0}";
      validateTaxName(name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isEdit() ? "Edit Tax" : "Add Tax"),
          bottom: AppConstants.getAppBarDivider,
          actions: [
            TextButton(
                onPressed: isValidInput
                    ? () {
                        context.read<TaxBloc>().add(AddTaxEvent(
                            taxName: taxNameController.text,
                            rate: taxRateController.text,
                            id: widget.taxEntity?.id));
                      }
                    : null,
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(
                      color: isValidInput
                          ? AppPallete.blueColor
                          : AppPallete.blueColor.withOpacity(0.5)),
                ))
          ],
        ),
        body: BlocConsumer<TaxBloc, TaxState>(listener: (context, state) {
          if (state is AddTaxErrorState) {
            showToastification(
                context, state.errorMessage, ToastificationType.error);
          }
          if (state is SuccessDeleteTax) {
            showToastification(context, "Tax deleted successfully.",
                ToastificationType.success);
            if (widget.refreshPage != null) {
              widget.refreshPage!();
            }
            AutoRouter.of(context).maybePop();
          }
          if (state is SuccessAddTax) {
            showToastification(
                context,
                "Tax ${isEdit() ? "updated" : "added"} successfully.",
                ToastificationType.success);
            if (widget.refreshPage != null) {
              widget.refreshPage!();
            }
            AutoRouter.of(context).maybePop();
          }
        }, builder: (BuildContext context, TaxState state) {
          if (state is TaxDeleteWaitingState) {
            return const LoadingPage(title: "Deleting tax...");
          }
          if (state is AddTaxLoadState) {
            return LoadingPage(
                title: isEdit() ? "Updating tax..." : "Adding tax...");
          }
          return Container(
            color: AppPallete.kF2F2F2,
            child: Column(
              children: [
                AppConstants.sizeBoxHeight10,
                NewInputViewWidget(
                  title: "Tax Name",
                  hintText: "Tax Name",
                  controller: taxNameController,
                  onChanged: (name) {
                    validateTaxName(name);
                  },
                ),
                NewInputViewWidget(
                    title: "Rate (%)",
                    hintText: "0",
                    isRequired: false,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.number,
                    controller: taxRateController),
                AppConstants.sizeBoxHeight10,
                if (widget.taxEntity != null)
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
                                      title: "Delete Tax",
                                      message:
                                          "Are you sure you want to delete this tax?",
                                      onTapDelete: () {
                                        debugPrint("on tap delete tax");
                                        Navigator.of(context).maybePop();
                                        context.read<TaxBloc>().add(
                                            DeleteTaxEvent(
                                                taxId: widget.taxEntity?.id ??
                                                    ""));
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
                  )
              ],
            ),
          );
        }));
  }

  void validateTaxName(String? name) {
    debugPrint("Entered Tax Name: $name");
    final isNotEmpty = name?.isNotEmpty ?? false;
    if (isValidInput != isNotEmpty) {
      isValidInput = isNotEmpty;
      setState(() {});
    }
  }
}
