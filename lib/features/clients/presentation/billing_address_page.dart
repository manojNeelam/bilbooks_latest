import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/models/country_model.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/new_multiline_input_widget.dart';
import 'package:billbooks_app/features/clients/presentation/Models/client_add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/widgets/country_list_popup_widget.dart';

@RoutePage()
class BillingAddressPage extends StatefulWidget {
  final ClientAddAddress? billingAddress;
  final Function(ClientAddAddress) callBack;
  const BillingAddressPage(
      {super.key, this.billingAddress, required this.callBack});

  @override
  State<BillingAddressPage> createState() => _BillingAddressPageState();
}

class _BillingAddressPageState extends State<BillingAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  List<CountryModel> countries = [];
  CountryModel? selectedCountry;
  bool isValidShippingForm = false;

  @override
  void initState() {
    populateData();
    super.initState();
  }

  void populateData() {
    loadCountries();
    final billingAddress = widget.billingAddress;
    if (billingAddress != null) {
      addressController.text = billingAddress.streetAddress;
      cityController.text = billingAddress.city;
      postalController.text = billingAddress.pincode;
      phoneNumberController.text = billingAddress.phoneNumber;
      stateController.text = billingAddress.state;
      selectedCountry = billingAddress.country;
      _validateForm();
    }
  }

  ClientAddAddress getBillingAddress() {
    return ClientAddAddress(
        streetAddress: addressController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: postalController.text,
        country: selectedCountry,
        phoneNumber: phoneNumberController.text);
  }

  void _validateForm() {
    isValidShippingForm = selectedCountry != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPallete.kF2F2F2,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
          title: const Text("Billing Address"),
          actions: [
            TextButton(
                onPressed: () {
                  widget.callBack(getBillingAddress());
                  AutoRouter.of(context).maybePop();
                },
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                )),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            Utils.hideKeyboard();
          },
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                AppConstants.sizeBoxHeight10,
                NewMultilineInputWidget(
                  controller: addressController,
                  title: 'Street Address',
                  hintText: 'Tap to Enter',
                  textCapitalization: TextCapitalization.words,
                  isRequired: false,
                ),
                NewInputViewWidget(
                    title: "City/Suburb",
                    hintText: "City/Suburb",
                    textCapitalization: TextCapitalization.words,
                    isRequired: false,
                    controller: cityController),
                NewInputViewWidget(
                    title: "State/Country",
                    hintText: "State/Country",
                    textCapitalization: TextCapitalization.words,
                    isRequired: false,
                    controller: stateController),
                NewInputViewWidget(
                    title: "Postal/Zipcode",
                    hintText: "Postal/Zipcode",
                    isRequired: false,
                    controller: postalController),
                InputDropdownView(
                    isRequired: true,
                    title: "Country",
                    defaultText: "Select Country",
                    value: selectedCountry?.name ?? "",
                    onPress: () {
                      _showCountryPopup();
                    }),
                NewInputViewWidget(
                    title: "Phone Number",
                    hintText: "Phone Number",
                    isRequired: false,
                    showDivider: false,
                    inputType: TextInputType.number,
                    controller: phoneNumberController),
              ],
            ),
          ),
        ));
  }

  Future<void> loadCountries() async {
    final String response =
        await rootBundle.loadString('assets/files/countries.json');
    countries = countryMainDataModelFromJson(response).country ?? [];
  }

  void _showCountryPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return CountryListPopupWidget(
              countries: countries,
              defaultCountry: selectedCountry,
              callBack: (country) {
                selectedCountry = country;
                _validateForm();
                setState(() {});
              });
        });
  }
}
