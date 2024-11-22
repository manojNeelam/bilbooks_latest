import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/generate_report_button_widget.dart';

@RoutePage()
class ReportProfitAndLossPage extends StatelessWidget {
  const ReportProfitAndLossPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profit and Loss",
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
              title: "Income",
              defaultText: "Billed",
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
