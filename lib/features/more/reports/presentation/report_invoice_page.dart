import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/generate_report_button_widget.dart';

@RoutePage()
class ReportInvoicePage extends StatelessWidget {
  const ReportInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Invoices Report",
        ),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: Container(
        color: AppPallete.kF2F2F2,
        child: Column(
          children: [
            AppConstants.sizeBoxHeight10,
            InputDropdownView(
              dropDownImageName: Icons.chevron_right,
              isRequired: false,
              title: "Date Range",
              defaultText: "All times",
              onPress: () {},
            ),
            InputDropdownView(
              isRequired: false,
              title: "Client",
              defaultText: "Tap to select",
              onPress: () {},
              dropDownImageName: Icons.chevron_right,
            ),
            InputDropdownView(
              isRequired: false,
              title: "Status",
              defaultText: "All",
              onPress: () {},
            ),
            AppConstants.sizeBoxHeight10,
            //AppConstants.sizeBoxHeight15,
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
