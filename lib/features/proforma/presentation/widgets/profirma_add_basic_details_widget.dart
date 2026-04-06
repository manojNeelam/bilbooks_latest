import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/new_multiline_input_widget.dart';
import 'package:billbooks_app/features/proforma/presentation/add_proforma_page.dart';
import 'package:flutter/material.dart';

class ProfirmaAddBasicDetailsWidget extends StatefulWidget {
  final ProformaRequestModel proformaRequestModel;
  final Function()? callback;

  const ProfirmaAddBasicDetailsWidget({
    super.key,
    required this.proformaRequestModel,
    required this.callback,
  });

  @override
  State<ProfirmaAddBasicDetailsWidget> createState() =>
      _ProfirmaAddBasicDetailsWidgetState();
}

class _ProfirmaAddBasicDetailsWidgetState
    extends State<ProfirmaAddBasicDetailsWidget> {
  DateTime selectedProformaDate = DateTime.now();
  final TextEditingController proformaHeadingController =
      TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController proformaNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _populateData();
  }

  @override
  void dispose() {
    proformaHeadingController.dispose();
    titleController.dispose();
    proformaNoController.dispose();
    super.dispose();
  }

  Future<void> _buildMaterialDatePicker(BuildContext context) async {
    final DateTime initialDate = selectedProformaDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppPallete.blueColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppPallete.blueColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedProformaDate) {
      setState(() {
        selectedProformaDate = picked;
      });
    }
  }

  void _populateData() {
    final reqModel = widget.proformaRequestModel;
    proformaHeadingController.text = reqModel.heading ?? "";
    proformaNoController.text = reqModel.no ?? "";
    titleController.text = reqModel.title ?? "";
    selectedProformaDate = reqModel.date ?? DateTime.now();
  }

  void _saveAndClose() {
    widget.proformaRequestModel.heading = proformaHeadingController.text;
    widget.proformaRequestModel.no = proformaNoController.text;
    widget.proformaRequestModel.title = titleController.text;
    widget.proformaRequestModel.date = selectedProformaDate;
    widget.callback?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: const Text("Proforma Details"),
        actions: [
          TextButton(
            onPressed: _saveAndClose,
            child: Text(
              "Done",
              style: AppFonts.regularStyle(color: AppPallete.blueColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              AppConstants.sizeBoxHeight10,
              NewInputViewWidget(
                title: 'Proforma Heading',
                hintText: "Heading",
                controller: proformaHeadingController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                isRequired: true,
                showDivider: false,
              ),
              AppConstants.sizeBoxHeight10,
              NewMultilineInputWidget(
                title: 'Title/Summary',
                hintText: "e.g. description of proforma",
                controller: titleController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.newline,
                isRequired: false,
                showDivider: false,
                textCapitalization: TextCapitalization.words,
              ),
              AppConstants.sizeBoxHeight10,
              NewInputViewWidget(
                title: 'Proforma #',
                hintText: "Proforma #",
                isBold: true,
                controller: proformaNoController,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                isRequired: true,
              ),
              InputDropdownView(
                title: "Proforma Date",
                value: selectedProformaDate.getDateString(),
                defaultText: selectedProformaDate.getDateString(),
                isRequired: true,
                showDropdownIcon: false,
                onPress: () {
                  _buildMaterialDatePicker(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
