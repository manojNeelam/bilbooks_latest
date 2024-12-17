import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:billbooks_app/features/auth/presentation/pages/signup_page.dart';
import 'package:billbooks_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:billbooks_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:billbooks_app/features/dashboard/domain/entity/authinfo_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/utils/column_settings_pref.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../localization/locales.dart';
import '../../../../router/app_router.dart';
import '../../../dashboard/domain/entity/column_settings_data.dart';
import '../widgets/auth_password_field.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isRemeberMe = false;
  bool isValidData = false;

  void _saveToken(String token) {}

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.white,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showToastification(
                  context, state.message, ToastificationType.error);
            } else if (state is AuthSuccess) {
              showToastification(
                  context,
                  state.user.data?.message ?? "Successfully logged in.",
                  ToastificationType.success);
              final token = state.user.data?.sessionToken;

              ColumnSettingsEntity? columnSettingsEntity =
                  state.user.data?.sessionData?.organization?.columnSettings;
              ColumnSettingsPref columnSettingsPref =
                  ColumnSettingsPref.fromInfo(
                      qty: columnSettingsEntity?.columnUnitsTitle,
                      rate: columnSettingsEntity?.columnRateTitle,
                      hideQty: columnSettingsEntity?.hideColumnQty,
                      itemTitle: columnSettingsEntity?.columnItemsTitle,
                      hideRate: columnSettingsEntity?.hideColumnRate);
              Utils.saveColumnSettings(columnSettingsPref);

              if (token != null) {
                Utils.saveToken(token);
              }
              AutoRouter.of(context).pushAndPopUntil(
                  GeneralRoute(
                      authInfoMainDataEntity: AuthInfoMainDataEntity(
                          success: true,
                          message: state.user.data?.message ??
                              "Successfully logged in.",
                          sessionData: state.user.data?.sessionData)),
                  predicate: (_) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingPage(title: "Logging...");
            }
            return Center(
              child: GestureDetector(
                onTap: () {
                  Utils.hideKeyboard();
                },
                child: SingleChildScrollView(
                  child: Column(
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
                                LocaleData.welcomeBack.getString(context),
                                style: AppFonts.mediumStyle(
                                    color: AppPallete.textColor, size: 24),
                                textAlign: TextAlign.center,
                              ),
                              AppConstants.sizeBoxHeight10,
                              Text(
                                "Login to continue with billbooks.",
                                style: AppFonts.regularStyle(),
                              ),
                              const SizedBox(
                                height: 25,
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
                                height: 30,
                              ),
                              AppButton(
                                callback: () async {
                                  context.read<AuthBloc>().add(AuthLogin(
                                      email: emailAddressController.text,
                                      password: passwordController.text));
                                },
                                isEnabled: isValidData,
                                title: "Login",
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context)
                                      .push(ForgotPasswordPageRoute());
                                },
                                child: Text(
                                  LocaleData.forgotPassword.getString(context),
                                  style: AppFonts.regularStyle(
                                      color: AppPallete.textColor),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Need an account?",
                                    style: AppFonts.regularStyle(),
                                  ),
                                  AppConstants.sizeBoxWidth10,
                                  GestureDetector(
                                    onTap: () {
                                      AutoRouter.of(context)
                                          .push(SignUpPageRoute());
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: AppFonts.regularStyle(
                                          color: AppPallete.blueColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void validateFields() {
    bool validate = false;
    final email = emailAddressController.text;
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      validate = false;
    } else {
      validate = true;
    }

    if (isValidData != validate) {
      isValidData = validate;
      setState(() {});
    }
  }
}

/*
BlocConsumer(
        builder: (BuildContext context, state) {
          if (state is AuthLoading) {
            return const LoadingPage(title: "Logging...");
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const AuthHeader(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            LocaleData.welcomeBack.getString(context),
                            style: AppFonts.authHeaderStyle(),
                          ),
                          Text(
                            LocaleData.needAnAccount.getString(context),
                            style: AppFonts.textStyle(),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            LocaleData.emailAddress.getString(context),
                            style: AppFonts.mediumStyle(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AuthField(
                            hintText: "User name",
                            controller: emailAddressController,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            LocaleData.password.getString(context),
                            style: AppFonts.mediumStyle(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          PasswordField(
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  isRemeberMe = !isRemeberMe;
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(isRemeberMe
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      LocaleData.rememberMe.getString(context),
                                      style: AppFonts.regularStyle(
                                          color: AppPallete.k666666),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  LocaleData.forgotPassword.getString(context),
                                  style: AppFonts.regularStyle(
                                      color: AppPallete.k666666),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          AppButton(callback: () async {
                            context.read<AuthBloc>().add(AuthLogin(
                                email: emailAddressController.text,
                                password: passwordController.text));
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is AuthFailure) {
            showToastification(
                context, state.message, ToastificationType.error);
          } else if (state is AuthSuccess) {
            showToastification(
                context,
                state.user.data?.message ?? "Successfully logged in.",
                ToastificationType.success);
            final token = state.user.data?.sessionToken;
            if (token != null) {
              Utils.saveToken(token);
            }
            AutoRouter.of(context).pushAndPopUntil(
                GeneralRoute(
                    authInfoMainDataEntity: AuthInfoMainDataEntity(
                        success: true,
                        message: state.user.data?.message ??
                            "Successfully logged in.",
                        sessionData: state.user.data?.sessionData)),
                predicate: (_) => false);
          }
        },
      ),
*/
