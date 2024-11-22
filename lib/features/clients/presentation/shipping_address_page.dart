import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/country_list_popup_widget.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/core/widgets/new_multiline_input_widget.dart';
import 'package:billbooks_app/features/clients/presentation/Models/client_add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/models/country_model.dart';

@RoutePage()
class ShippingAddressPage extends StatefulWidget {
  final ClientAddAddress? billingAddress;
  final ClientAddAddress? shippingAddress;
  final Function(ClientAddAddress) callBack;
  const ShippingAddressPage(
      {super.key,
      this.billingAddress,
      this.shippingAddress,
      required this.callBack});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
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
    final shippingAddress = widget.shippingAddress;
    if (shippingAddress != null) {
      addressController.text = shippingAddress.streetAddress;
      cityController.text = shippingAddress.city;
      postalController.text = shippingAddress.pincode;
      phoneNumberController.text = shippingAddress.phoneNumber;
      stateController.text = shippingAddress.state;
      selectedCountry = shippingAddress.country;
      validateForm();
    }
  }

  void copyBillingAddress() {
    final billingAddress = widget.billingAddress;
    if (billingAddress != null) {
      addressController.text = billingAddress.streetAddress;
      cityController.text = billingAddress.city;
      postalController.text = billingAddress.pincode;
      phoneNumberController.text = billingAddress.phoneNumber;
      stateController.text = billingAddress.state;
      selectedCountry = billingAddress.country;
      validateForm();
    }
  }

  ClientAddAddress getAShippingAddress() {
    return ClientAddAddress(
        streetAddress: addressController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: postalController.text,
        country: selectedCountry,
        phoneNumber: phoneNumberController.text);
  }

  void validateForm() {
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
          title: const Text("Shipping Address"),
          actions: [
            TextButton(
                onPressed: isValidShippingForm
                    ? () {
                        widget.callBack(getAShippingAddress());
                        AutoRouter.of(context).maybePop();
                      }
                    : null,
                child: Text(
                  "Save",
                  style: AppFonts.regularStyle(
                      color: isValidShippingForm
                          ? AppPallete.blueColor
                          : AppPallete.blueColor.withOpacity(0.3)),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppPallete.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            copyBillingAddress();
                            setState(() {});
                          },
                          child: Text(
                            "Copy billing address",
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
                          )),
                    ],
                  ),
                ),
                AppConstants.sizeBoxHeight10,
                NewMultilineInputWidget(
                  controller: addressController,
                  title: 'Street Address',
                  hintText: 'Tap to Enter',
                  isRequired: false,
                ),
                NewInputViewWidget(
                    title: "City/Suburb",
                    hintText: "City/Suburb",
                    isRequired: false,
                    controller: cityController),
                NewInputViewWidget(
                    title: "State/Country",
                    hintText: "State/Country",
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
                    value: selectedCountry?.name ?? "",
                    defaultText: selectedCountry?.name ?? "Select Country",
                    onPress: () {
                      _showCountryPopup();
                    }),
                NewInputViewWidget(
                  title: "Phone Number",
                  hintText: "Phone Number",
                  isRequired: false,
                  showDivider: false,
                  controller: phoneNumberController,
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.done,
                ),
                AppConstants.sizeBoxHeight15
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
                validateForm();
                setState(() {});
              });
        });
  }
}
