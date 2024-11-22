import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/widgets/input_dropdown_view.dart';
import '../../../../core/widgets/new_inputview_widget.dart';
import '../../../../core/widgets/new_multiline_input_widget.dart';
import '../../../invoice/presentation/add_new_invoice_page.dart';

@RoutePage()
class EstimateAddInfoDetails extends StatefulWidget {
  final InvoiceRequestModel invoiceRequestModel;
  final Function()? callback;
  const EstimateAddInfoDetails({
    super.key,
    required this.invoiceRequestModel,
    required this.callback,
  });

  @override
  State<EstimateAddInfoDetails> createState() => _EstimateAddInfoDetailsState();
}

class _EstimateAddInfoDetailsState extends State<EstimateAddInfoDetails> {
  TextEditingController titleController = TextEditingController();
  TextEditingController estimateNoController = TextEditingController();
  TextEditingController poNoController = TextEditingController();
  DateTime selectedEstimateDate = DateTime.now();
  DateTime? expiryDate;
  bool isValidateFormData = false;

  @override
  void initState() {
    _populateData();
    super.initState();
  }

  void _validateForm() {
    bool isValid = estimateNoController.text.isNotEmpty;
    if (isValidateFormData != isValid) {
      isValidateFormData = isValid;
      setState(() {});
    }
  }

  void _populateData() {
    titleController.text = widget.invoiceRequestModel.title ?? "";
    estimateNoController.text = widget.invoiceRequestModel.no ?? "";
    poNoController.text = widget.invoiceRequestModel.poNumber ?? "";
    selectedEstimateDate = widget.invoiceRequestModel.date ?? DateTime.now();
    expiryDate = widget.invoiceRequestModel.expiryDate;
    _validateForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: const Text("Estimate Details"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: isValidateFormData
                  ? () {
                      widget.invoiceRequestModel.no = estimateNoController.text;
                      widget.invoiceRequestModel.title = titleController.text;
                      widget.invoiceRequestModel.date = selectedEstimateDate;
                      widget.invoiceRequestModel.expiryDate = expiryDate;
                      widget.invoiceRequestModel.poNumber = poNoController.text;
                      widget.callback!();
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Text(
                "Done",
                style: AppFonts.regularStyle(
                  color: isValidateFormData
                      ? AppPallete.blueColor
                      : AppPallete.lightBlueColor,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          AppConstants.sizeBoxHeight10,
          NewMultilineInputWidget(
            title: 'Title/Summary',
            hintText: "e.g. description of estimate",
            controller: titleController,
            inputType: TextInputType.name,
            inputAction: TextInputAction.newline,
            isRequired: false,
            showDivider: false,
          ),
          AppConstants.sizeBoxHeight10,
          NewInputViewWidget(
            title: 'Estimate #',
            hintText: "Estimate #",
            controller: estimateNoController,
            inputType: TextInputType.name,
            inputAction: TextInputAction.next,
            isRequired: true,
            isBold: true,
            onChanged: (val) {
              _validateForm();
            },
          ),
          InputDropdownView(
              title: "Estimate Date",
              value: selectedEstimateDate.getDateString(),
              defaultText: selectedEstimateDate.getDateString(),
              isRequired: true,
              showDropdownIcon: false,
              onPress: () {
                buildMaterialDatePicker(context, EnumEstimateDateType.date);
              }),
          InputDropdownView(
              title: "Expiry Date",
              value: expiryDate?.getDateString() ?? "",
              defaultText: expiryDate?.getDateString() ?? "",
              isRequired: false,
              showDropdownIcon: false,
              onPress: () {
                buildMaterialDatePicker(context, EnumEstimateDateType.expiry);
              }),
          NewInputViewWidget(
            title: 'P.O. Number',
            hintText: "P.O. Number",
            isRequired: false,
            controller: poNoController,
            inputType: TextInputType.name,
            inputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(
    BuildContext context,
    EnumEstimateDateType type,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: type == EnumEstimateDateType.date
            ? selectedEstimateDate
            : expiryDate,
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
    DateTime? selectedDate =
        type == EnumEstimateDateType.date ? selectedEstimateDate : expiryDate;
    if (picked != null && picked != selectedDate) {
      setState(() {
        if (type == EnumEstimateDateType.date) {
          selectedEstimateDate = picked;
        } else {
          expiryDate = picked;
        }
      });
    }
  }
}

enum EnumEstimateDateType { expiry, date }
