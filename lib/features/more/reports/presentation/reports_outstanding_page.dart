import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/generate_report_button_widget.dart';

@RoutePage()
class ReportOutstandingsPage extends StatelessWidget {
  const ReportOutstandingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Outstandings Report",
        ),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: Container(
        color: AppPallete.kF2F2F2,
        child: Column(
          children: [
            AppConstants.sizeBoxHeight10,
            InputDropdownView(
              isRequired: false,
              title: "Country",
              defaultText: "All",
              onPress: () {},
            ),
            AppConstants.sizeBoxHeight10,
            GenerateReportButtonWidget(
              onpressed: () {},
              title: "Generate Report",
            )
          ],
        ),
      ),
    );
  }
}
