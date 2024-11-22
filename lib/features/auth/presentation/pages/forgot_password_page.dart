import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/utils/show_toast.dart';
import 'package:billbooks_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/usecases/user_signup.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_password_field.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isValidData = false;
  bool isApiInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        bottom: AppConstants.getAppBarDivider,
        leading: IconButton(
          onPressed: () {
            AutoRouter.of(context).maybePop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: AppPallete.blueColor,
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordReqFailure) {
            isApiInProgress = false;
            showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is ResetPasswordReqSuccess) {
            if (state.res.data?.success ?? false) {
              final hashKey = state.res.data?.hashkey ?? "";
              if (hashKey.isNotEmpty) {
                _resetPassword(hashKey);
              } else {
                isApiInProgress = false;
              }
            } else {
              isApiInProgress = false;
            }
          }
          if (state is ResetPasswordFailure) {
            isApiInProgress = false;

            showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is ResetPasswordSuccess) {
            isApiInProgress = false;
            AutoRouter.of(context).maybePop();
            showToastification(
                context,
                state.res.data?.message ?? "Successfully reset password.",
                ToastificationType.success);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppConstants.sizeBoxHeight15,
                        Text(
                          "Enter the email address you used to register with Billbooks.",
                          style: AppFonts.regularStyle(),
                        ),
                        AppConstants.sizeBoxHeight15,
                        AuthField(
                          hintText: "Email Address",
                          controller: emailAddressController,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          onChanged: (val) {
                            _validateFields();
                          },
                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppPallete.borderColor,
                          ),
                        ),
                        AppConstants.sizeBoxHeight15,
                        PasswordField(
                          controller: passwordController,
                          onChanged: (val) {
                            _validateFields();
                          },
                          hint: "Password",
                        ),
                        AppConstants.sepSizeBox5,
                        Text(
                          "Password length should be greater than 7 characters",
                          style: AppFonts.regularStyle(size: 11),
                        ),
                        AppConstants.sizeBoxHeight15,
                        PasswordField(
                          controller: confirmPasswordController,
                          onChanged: (val) {
                            _validateFields();
                          },
                          hint: "Confirm Password",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    callback: () async {
                      if (!isApiInProgress) {
                        isApiInProgress = true;
                        _resetPasswordRequest();
                      }
                    },
                    isEnabled: isValidData,
                    title: "Submit",
                  ),
                ],
              ),
              if (state is ResetPasswordLoading ||
                  state is ResetPasswordReqLoading)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(),
                      AppConstants.sizeBoxWidth10,
                      Text(
                        "Loading...",
                        style: AppFonts.regularStyle(),
                      )
                    ],
                  )),
                )
            ],
          );
        },
      ),
    );
  }

  void _resetPasswordRequest() {
    context.read<AuthBloc>().add(ResetPasswordReqEvent(
        params: ResetPasswordReqUseCaseReqParams(
            email: emailAddressController.text)));
  }

  void _resetPassword(String hashKey) {
    context.read<AuthBloc>().add(ResetPasswordEvent(
            params: ResetPasswordUseCaseReqParams(
          hashkey: hashKey,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        )));
  }

  void _validateFields() {
    bool validate = false;
    final email = emailAddressController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        password.length < 8 ||
        confirmPassword.length < 8 ||
        password != confirmPassword) {
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
