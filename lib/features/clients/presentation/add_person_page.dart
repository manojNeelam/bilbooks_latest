import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/features/clients/presentation/Models/client_person_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddPersonPage extends StatefulWidget {
  final ClientPersonModel? clientPersonModel;
  final Function(ClientPersonModel?) callback;
  const AddPersonPage(
      {super.key, this.clientPersonModel, required this.callback});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState() {
    debugPrint("Initstate called");
    _populateData();
    super.initState();
  }

  void _populateData() {
    if (widget.clientPersonModel != null) {
      final clientPersonModel = widget.clientPersonModel!;
      nameController.text = clientPersonModel.name;
      emailController.text = clientPersonModel.email;
      phoneController.text = clientPersonModel.phoneNumber;
      validateForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BuildContext called");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Person"),
        actions: [
          TextButton(
              onPressed: () {
                widget.callback(ClientPersonModel(
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneController.text));
                Navigator.of(context).pop();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(
                    color: isFormValid
                        ? AppPallete.blueColor
                        : AppPallete.blueColor.withOpacity(0.3)),
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
      ),
      body: GestureDetector(
        onTap: () {
          Utils.hideKeyboard();
        },
        child: Container(
          color: AppPallete.kF2F2F2,
          child: Column(
            children: [
              const ItemSeparator(),
              AppConstants.sizeBoxHeight10,
              NewInputViewWidget(
                controller: nameController,
                hintText: "Name",
                title: "Name",
                isRequired: true,
                showDivider: true,
                onChanged: (val) {
                  validateForm();
                },
              ),
              NewInputViewWidget(
                controller: emailController,
                hintText: "Email",
                title: "Email",
                isRequired: true,
                showDivider: true,
                inputType: TextInputType.emailAddress,
                onChanged: (val) {
                  validateForm();
                },
              ),
              NewInputViewWidget(
                controller: phoneController,
                hintText: "Phone",
                title: "Phone",
                isRequired: false,
                showDivider: false,
                inputType: TextInputType.phone,
                inputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateForm() {
    bool validate = false;
    final name = nameController.text;
    final email = emailController.text;
    if (name.isNotEmpty && email.isNotEmpty) {
      validate = true;
    }
    if (isFormValid != validate) {
      isFormValid = validate;
      setState(() {});
    }
  }
}
