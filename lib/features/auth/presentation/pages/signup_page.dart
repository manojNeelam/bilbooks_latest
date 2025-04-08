import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/models/country_model.dart';
import '../../../../core/models/language_model.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/column_settings_pref.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/country_list_popup_widget.dart';
import '../../../../core/widgets/language_list_popup_widget.dart';
import '../../../dashboard/domain/entity/authinfo_entity.dart';
import '../../domain/usecases/user_signup.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_password_field.dart';
import 'package:collection/collection.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<CountryModel> countries = [];
  CountryModel? selectedCountry;
  List<LanguageModel> languages = [];
  LanguageModel? selectedLanguage;

  bool isValidData = false;
  bool isAPILoading = false;

  @override
  void initState() {
    loadCountries();
    _loadLanguages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.white,
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          Utils.hideKeyboard();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is RegisterUserFailure) {
                  isAPILoading = false;
                  showToastification(
                      context, state.message, ToastificationType.error);
                }
                if (state is RegisterUserSuccess) {
                  isAPILoading = false;
                  showToastification(
                      context,
                      state.res.data?.message ??
                          "Successfully registered user.",
                      ToastificationType.success);
                  dismiss();
                }
              },
              builder: (context, state) {
                return PopScope(
                  canPop: true,
                  onPopInvokedWithResult: (isDone, result) {
                    Utils.hideKeyboard();
                  },
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AuthHeader(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "New Sign Up",
                                    style: AppFonts.mediumStyle(
                                        color: AppPallete.textColor, size: 24),
                                    textAlign: TextAlign.center,
                                  ),
                                  AppConstants.authFieldVerticalPadding,
                                  AuthField(
                                    hintText: "Company Name",
                                    controller: companyNameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.text,
                                    onChanged: (val) {
                                      validateFields();
                                    },
                                    prefixIcon: const Icon(
                                      Icons.home,
                                      color: AppPallete.borderColor,
                                    ),
                                  ),
                                  AppConstants.authFieldVerticalPadding,
                                  AuthField(
                                    hintText: "Full Name",
                                    controller: nameController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.text,
                                    onChanged: (val) {
                                      validateFields();
                                    },
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: AppPallete.borderColor,
                                    ),
                                  ),
                                  AppConstants.authFieldVerticalPadding,
                                  AuthField(
                                    hintText: "Email Address",
                                    controller: emailAddressController,
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.emailAddress,
                                    onChanged: (val) {
                                      validateFields();
                                    },
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: AppPallete.borderColor,
                                    ),
                                  ),
                                  AppConstants.authFieldVerticalPadding,
                                  PasswordField(
                                    controller: passwordController,
                                    onChanged: (val) {
                                      validateFields();
                                    },
                                    hint: "Password",
                                  ),
                                  AppConstants.authFieldVerticalPadding,
                                  AuthDropDownWidget(
                                    value: (selectedCountry == null)
                                        ? ""
                                        : selectedCountry?.name ?? "",
                                    defaultText: "Country",
                                    selectedObject: (id, name) {},
                                    onTapItem: () {
                                      _showCountryPopup();
                                    },
                                  ),
                                  AppConstants.authFieldVerticalPadding,
                                  AuthDropDownWidget(
                                    value: (selectedLanguage == null)
                                        ? ""
                                        : selectedLanguage?.name ?? "",
                                    defaultText: "Language",
                                    selectedObject: (id, name) {},
                                    onTapItem: () {
                                      _showLanguagePopup();
                                    },
                                  ),
                                  AppConstants.authFieldVerticalPadding,
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              "By clicking 'Sign up' you agree to our ",
                                          style: AppFonts.regularStyle(),
                                          children: [
                                        TextSpan(
                                            text: "Terms of Service",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(AppConstants
                                                    .termsofService);
                                                // "https://www.billbooks.com/terms-of-service/";
                                                // print('Privacy "');
                                              },
                                            style: AppFonts.regularStyle(
                                                    color: AppPallete.blueColor)
                                                .copyWith(height: 1.4)),
                                        TextSpan(
                                            text: " and ",
                                            style: AppFonts.regularStyle(
                                                color: AppPallete.textColor)),
                                        TextSpan(
                                            text: "Privacy Policy",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(
                                                    AppConstants.privacyPolicy);

                                                // "https://www.billbooks.com/privacy-policy/";
                                                // print('Privacy Policy"');
                                              },
                                            style: AppFonts.regularStyle(
                                                color: AppPallete.blueColor)),
                                      ])),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  AppButton(
                                    callback: () async {
                                      if (!isAPILoading) {
                                        isAPILoading = true;
                                        context.read<AuthBloc>().add(
                                            RegisterUserEvent(
                                                params:
                                                    RegisterUserUseCaseReqParams(
                                                        company:
                                                            companyNameController
                                                                .text,
                                                        email:
                                                            emailAddressController
                                                                .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        name:
                                                            nameController.text,
                                                        country: selectedCountry
                                                                ?.countryId ??
                                                            "",
                                                        lang: selectedLanguage
                                                                ?.languageId ??
                                                            "")));
                                      }
                                    },
                                    isEnabled: isValidData,
                                    title: "Sign Up",
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "Already have a Billbooks Account?",
                                          style: AppFonts.regularStyle(),
                                        ),
                                        TextSpan(
                                          text: "\nLogin",
                                          style: AppFonts.regularStyle(
                                              color: AppPallete.blueColor),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              dismiss();
                                            },
                                        ),
                                        TextSpan(
                                          text: " here",
                                          style: AppFonts.regularStyle(),
                                        )
                                      ])),
                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //   children: [
                                  //     Text(
                                  //       //Already have a Billbooks Account? Login here
                                  //       "Already have a Billbooks Account?",
                                  //       style: AppFonts.regularStyle(),
                                  //     ),
                                  //     //AppConstants.sizeBoxWidth10,
                                  //     GestureDetector(
                                  //       onTap: () {
                                  //         AutoRouter.of(context).maybePop();
                                  //       },
                                  //       child: Text(
                                  //         "\nLogin",
                                  //         style: AppFonts.regularStyle(
                                  //             color: AppPallete.blueColor),
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       " here",
                                  //       style: AppFonts.regularStyle(),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      if (state is RegisterUserLoading)
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: LoadingAnimationWidget.hexagonDots(
                              color: AppPallete.blueColor,
                              size: 50,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      )),
    );
  }

  void validateFields() {
    bool validate = false;
    final email = emailAddressController.text;
    final password = passwordController.text;
    final companyName = companyNameController.text;
    final fullName = nameController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        companyName.isEmpty ||
        fullName.isEmpty ||
        selectedCountry == null ||
        selectedLanguage == null) {
      validate = false;
    } else {
      validate = true;
    }

    if (isValidData != validate) {
      isValidData = validate;
      setState(() {});
    }
  }

  Future<void> loadCountries() async {
    final String response =
        await rootBundle.loadString('assets/files/countries.json');
    countries = countryMainDataModelFromJson(response).country ?? [];
    selectedCountry = countries.firstWhereOrNull((returnedCountry) {
      if (returnedCountry.countryId == "244") {
        return true;
      }
      return false;
    });
    _reRenderUI();
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
                validateFields();
                _reRenderUI();
              });
        });
  }

  Future<void> _loadLanguages() async {
    final String response =
        await rootBundle.loadString('assets/files/languages.json');
    languages = languageMainDataModelFromJson(response).data?.language ?? [];

    selectedLanguage = languages.firstWhere((returnedLanguage) {
      if (returnedLanguage.name?.toLowerCase() == "english") {
        return true;
      }
      return false;
    });
    _reRenderUI();
  }

  void _showLanguagePopup() {
    showDialog(
        context: context,
        builder: (context) {
          return LanguageListPopupWidget(
              languages: languages,
              defaultLanguage: selectedLanguage,
              callBack: (language) {
                selectedLanguage = language;
                validateFields();
                _reRenderUI();
              });
        });
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  dismiss() {
    AutoRouter.of(context).maybePop();
  }

  _reRenderUI() {
    setState(() {});
  }
}

class AuthDropDownWidget extends StatelessWidget {
  final String value;
  final String defaultText;
  final Function(String, String) selectedObject;
  final Function() onTapItem;
  const AuthDropDownWidget({
    super.key,
    required this.value,
    required this.defaultText,
    required this.selectedObject,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem();
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: AppPallete.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppPallete.borderColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppConstants.sizeBoxWidth10,
                Icon(
                  Icons.location_city,
                  color: AppPallete.borderColor,
                  size: 20,
                ),
                AppConstants.sizeBoxWidth15,
                Text(
                  value.isEmpty ? defaultText : value,
                  style: AppFonts.regularStyle(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_drop_down,
                color: AppPallete.borderColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
