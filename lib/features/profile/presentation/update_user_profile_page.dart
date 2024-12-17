import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/item_separator.dart';
import '../../dashboard/domain/entity/authinfo_entity.dart';

@RoutePage()
class UpdateUserProfilePage extends StatefulWidget {
  final AuthInfoMainDataEntity? authInfoMainDataEntity;
  const UpdateUserProfilePage(
      {super.key, required this.authInfoMainDataEntity});

  @override
  State<UpdateUserProfilePage> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  TextEditingController curretPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController cofirmPasswordController = TextEditingController();
  bool isChangeEmailAddress = false;
  bool isChangePassword = false;
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    userEmail = widget.authInfoMainDataEntity?.sessionData?.user?.email ?? "";
    fullNameController.text =
        widget.authInfoMainDataEntity?.sessionData?.user?.name ?? "";
  }

  void toggleChangeEmailAddress() {
    isChangeEmailAddress = !isChangeEmailAddress;
    setState(() {});
  }

  void toggleChangePassword() {
    isChangePassword = !isChangePassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: const Text("My Profile"),
        bottom: AppConstants.getAppBarDivider,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppConstants.sizeBoxHeight10,
            NewInputViewWidget(
                title: "Full Name",
                hintText: "Full Name",
                showDivider: false,
                controller: fullNameController),
            AppConstants.sizeBoxHeight10,
            if (isChangeEmailAddress)
              Container(
                color: AppPallete.white,
                child: Column(
                  children: [
                    NewInputViewWidget(
                      title: "New Email",
                      hintText: "New Email",
                      controller: newEmailController,
                      isRequired: true,
                    ),
                    NewInputViewWidget(
                      title: "Confirm Email",
                      hintText: "Confirm Email",
                      controller: confirmEmailController,
                      isRequired: true,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            toggleChangeEmailAddress();
                          },
                          child: Text(
                            "Cancel",
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
                          )),
                    )
                  ],
                ),
              ),
            if (!isChangeEmailAddress)
              Container(
                color: AppPallete.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666),
                          ),
                          Text(
                            userEmail,
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666),
                          )
                        ],
                      ),
                    ),
                    const ItemSeparator(),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            toggleChangeEmailAddress();
                          },
                          child: Text(
                            "Change email address",
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
                          )),
                    ),
                  ],
                ),
              ),
            AppConstants.sizeBoxHeight10,
            if (!isChangePassword)
              Container(
                color: AppPallete.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Password",
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666),
                          ),
                          Text(
                            "*********",
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666),
                          )
                        ],
                      ),
                    ),
                    const ItemSeparator(),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            toggleChangePassword();
                          },
                          child: Text(
                            "Change password",
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
                          )),
                    ),
                  ],
                ),
              ),
            if (isChangePassword)
              Container(
                color: AppPallete.white,
                child: Column(
                  children: [
                    NewInputViewWidget(
                      title: "Current Password",
                      hintText: "Current Password",
                      controller: curretPasswordController,
                      isRequired: true,
                    ),
                    NewInputViewWidget(
                      title: "New Password",
                      hintText: "New Password",
                      controller: newPasswordController,
                      isRequired: true,
                    ),
                    NewInputViewWidget(
                      title: "Confirm Password",
                      hintText: "Confirm Password",
                      controller: cofirmPasswordController,
                      isRequired: true,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            toggleChangePassword();
                          },
                          child: Text(
                            "Cancel",
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
                          )),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
