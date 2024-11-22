import 'package:billbooks_app/core/models/country_model.dart';

class ClientAddAddress {
  String streetAddress;
  String city;
  String state;
  String pincode;
  CountryModel? country;
  String phoneNumber;

  ClientAddAddress(
      {required this.streetAddress,
      required this.city,
      required this.state,
      required this.pincode,
      this.country,
      required this.phoneNumber});
}
