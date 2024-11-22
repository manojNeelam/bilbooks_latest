import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UpdateEmailTemplatePage extends StatelessWidget {
  final String title;
  const UpdateEmailTemplatePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        bottom: AppConstants.getAppBarDivider,
        title: Text(title),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          Utils.hideKeyboard();
        },
        child: SingleChildScrollView(
          child: Container(
            color: AppPallete.kF2F2F2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppPallete.kF2F2F2,
                  padding: AppConstants.horizonta16lVerticalPadding10,
                  child: Text(
                    "Subject",
                    style: AppFonts.regularStyle(),
                  ),
                ),
                Container(
                  color: AppPallete.white,
                  padding: AppConstants.horizotal16,
                  child: TextField(
                    controller: subjectController,
                    style: AppFonts.regularStyle(),
                    decoration: InputDecoration(
                        hintText: "Subject",
                        isDense: true,
                        contentPadding: AppConstants.contentViewPadding,
                        fillColor: AppPallete.white,
                        filled: true,
                        border: InputBorder.none,
                        hintStyle: AppFonts.hintStyle()),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Container(
                  color: AppPallete.kF2F2F2,
                  padding: AppConstants.horizonta16lVerticalPadding10,
                  child: Text(
                    "Message",
                    style: AppFonts.regularStyle(),
                  ),
                ),
                Container(
                  color: AppPallete.white,
                  padding: AppConstants.horizotal16,
                  child: TextField(
                    controller: messageController,
                    minLines: 8,
                    maxLines: 12,
                    style: AppFonts.regularStyle(),
                    decoration: InputDecoration(
                        hintText: "Message",
                        isDense: true,
                        contentPadding: AppConstants.contentViewPadding,
                        fillColor: AppPallete.white,
                        filled: true,
                        border: InputBorder.none,
                        hintStyle: AppFonts.hintStyle()),
                    textInputAction: TextInputAction.newline,
                  ),
                ),
                Container(
                  padding: AppConstants.horizonta16lVerticalPadding10,
                  child: Text(
                    "Placeholder",
                    style: AppFonts.regularStyle(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
