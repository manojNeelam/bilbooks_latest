import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';
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
                  AutoRouter.of(context).maybePop();
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Register with us!",
                                    style: AppFonts.mediumStyle(
                                        color: AppPallete.textColor, size: 24),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  AuthField(
                                    hintText: "Company Name",
                                    controller: companyNameController,
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.name,
                                    onChanged: (val) {
                                      validateFields();
                                    },
                                    prefixIcon: const Icon(
                                      Icons.home,
                                      color: AppPallete.borderColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  AuthField(
                                    hintText: "Full Name",
                                    controller: nameController,
                                    inputAction: TextInputAction.next,
                                    inputType: TextInputType.name,
                                    onChanged: (val) {
                                      validateFields();
                                    },
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: AppPallete.borderColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  PasswordField(
                                    controller: passwordController,
                                    onChanged: (val) {
                                      validateFields();
                                    },
                                    hint: "Password",
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              "By clicking 'Sign up' you agree to our ",
                                          style: AppFonts.regularStyle(),
                                          children: [
                                        TextSpan(
                                            text: "Terms of Service",
                                            style: AppFonts.regularStyle(
                                                color: AppPallete.blueColor)),
                                        TextSpan(
                                            text: " and ",
                                            style: AppFonts.regularStyle(
                                                color: AppPallete.textColor)),
                                        TextSpan(
                                            text: "Privacy Policy",
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account.",
                                        style: AppFonts.regularStyle(),
                                      ),
                                      AppConstants.sizeBoxWidth10,
                                      GestureDetector(
                                        onTap: () {
                                          AutoRouter.of(context).maybePop();
                                        },
                                        child: Text(
                                          "Login",
                                          style: AppFonts.regularStyle(
                                              color: AppPallete.blueColor),
                                        ),
                                      )
                                    ],
                                  ),
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
