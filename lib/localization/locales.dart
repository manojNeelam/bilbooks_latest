import 'package:flutter_localization/flutter_localization.dart';

// ignore: constant_identifier_names
const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
];

mixin LocaleData {
  static const String title = "title";
  static const String body = "body";

  //New Client Start
  static const String companyNameTitle = "Company Name";
  static const String primaryContactTitle = "Primary Contact";
  static const String emailTitle = "Email";
  static const String phoneTitle = "Phone";
  static const String addressDetailsHeaderTitle = "Address Details";
  static const String billingAddressTitle = "Billing Address";
  static const String shippingAddressTitle = "Shipping Address";
  static const String otherDetailsHeaderTitle = "Other Details";

  static const String currencyTitle = "Currency";
  static const String paymentTermsTitle = "Payment Terms";
  static const String companyTaxIDTitle = "CompanyTax ID";
  static const String websiteTitle = "Website";

  static const String languageTitle = "Language";
  static const String contactPersonHeaderTitle = "Contact Person";
  static const String addNewContact = "Add new contact";
  static const String remarksTitle = "Remarks";
  static const String remarksHint = "Note for internal use";
  //New Client End

  //Auth Start
  static const String welcomeBack = "welcomeback";
  static const String needAnAccount = "need_an_account";
  static const String signup = "sign_up";
  static const String emailAddress = "email_address";
  static const String password = "password";
  static const String rememberMe = "remember_me";
  static const String forgotPassword = "forgot_password";
  static const String login = "login";

  static const String registerWithUs = "register_with_us";
  static const String alreadyHaveAnAccount = "already_have_account";
  //Auth End

  static const Map<String, dynamic> EN = {
    title: "Localization",
    body: "welcome to the application %a",
    companyNameTitle: "Company Name",
    primaryContactTitle: "Primary Contact",
    emailTitle: "Email",
    phoneTitle: "Phone",
    addressDetailsHeaderTitle: "Address Details",
    billingAddressTitle: "Billing Address",
    shippingAddressTitle: "Shipping Address",
    otherDetailsHeaderTitle: "Other Details",
    currencyTitle: "Currency",
    paymentTermsTitle: "Payment Terms",
    companyTaxIDTitle: "CompanyTax ID",
    websiteTitle: "Website",
    languageTitle: "Language",
    contactPersonHeaderTitle: "Contact Person",
    addNewContact: "Add new contact",
    remarksTitle: "Remarks",
    remarksHint: "Note for internal use",
    welcomeBack: "Welcome back!",
    needAnAccount: "Need an account?",
    signup: "Sign up",
    emailAddress: "Email Address ",
    password: "Password",
    rememberMe: "Remember me",
    forgotPassword: "Reset Password ?",
    login: "Login",
    registerWithUs: "Register with us!",
    alreadyHaveAnAccount: "Already have an account.",
  };
}
