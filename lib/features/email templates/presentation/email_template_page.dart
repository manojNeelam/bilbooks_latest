import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';

enum EnumEmailTemplate { invoice, estimate, remainder, thankyou }

extension EnumEmailTemplateExtension on EnumEmailTemplate {
  (String, String) get titleandDesc {
    switch (this) {
      case EnumEmailTemplate.invoice:
        return (
          "Send Invoice",
          "Email that goes out when you send invoice to your client"
        );
      case EnumEmailTemplate.estimate:
        return (
          "Send Estimate",
          "Email that goes out when you send estimates to your clients"
        );
      case EnumEmailTemplate.remainder:
        return (
          "Payment Remainder",
          "Set message for sending payment remainders"
        );
      case EnumEmailTemplate.thankyou:
        return (
          "Payment Thank-you",
          "Message sent upon receiving a successful payment"
        );
    }
  }
}

@RoutePage()
class EmailTemplatePage extends StatelessWidget {
  const EmailTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Template"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: ListView.builder(
          itemCount: EnumEmailTemplate.values.length,
          itemBuilder: (context, index) {
            final item = EnumEmailTemplate.values[index];
            final (String title, String desc) = item.titleandDesc;
            return GestureDetector(
                onTap: () {
                  switch (item) {
                    case EnumEmailTemplate.invoice:
                      AutoRouter.of(context).push(
                          UpdateEmailTemplatePageRoute(title: "Send Invoice"));
                    case EnumEmailTemplate.estimate:
                      AutoRouter.of(context).push(
                          UpdateEmailTemplatePageRoute(title: "Send Estimate"));
                    case EnumEmailTemplate.remainder:
                      AutoRouter.of(context).push(UpdateEmailTemplatePageRoute(
                          title: "Payment Reminder"));
                    case EnumEmailTemplate.thankyou:
                      AutoRouter.of(context).push(UpdateEmailTemplatePageRoute(
                          title: "Payment Thank-you"));
                  }
                },
                child: EmailTemplateWidget(title: title, desc: desc));
          }),
    );
  }
}

class EmailTemplateWidget extends StatelessWidget {
  const EmailTemplateWidget({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.horizotal16,
      color: AppPallete.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: AppConstants.verticalPadding10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.regularStyle(),
                  ),
                  Text(
                    desc,
                    style: AppFonts.regularStyle(
                        color: AppPallete.k666666, size: 14),
                  )
                ],
              ),
            ),
          ),
          AppConstants.sizeBoxWidth10,
          const Icon(
            Icons.chevron_right,
            color: AppPallete.borderColor,
          )
        ],
      ),
    );
  }
}
