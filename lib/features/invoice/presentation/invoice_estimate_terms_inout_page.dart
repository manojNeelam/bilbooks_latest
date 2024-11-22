import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';

@RoutePage()
class InvoiceEstimateTermsInoutPage extends StatelessWidget {
  final String terms;
  final Function(String) callback;
  const InvoiceEstimateTermsInoutPage({
    super.key,
    required this.terms,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = terms;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
        bottom: AppConstants.getAppBarDivider,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                callback(controller.text);
                AutoRouter.of(context).maybePop();
              },
              child: Text(
                "Done",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              )),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.multiline,
            minLines: 100,
            maxLines: 99999,
            textInputAction: TextInputAction.newline,
            style: AppFonts.regularStyle(),
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 0),
                fillColor: AppPallete.white,
                filled: true,
                border: InputBorder.none,
                hintText: "Mention your company's terms & conditions",
                hintStyle: AppFonts.hintStyle()),
          ),
        ),
      ),
    );
  }
}
