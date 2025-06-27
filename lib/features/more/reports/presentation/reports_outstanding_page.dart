import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:billbooks_app/features/more/reports/presentation/bloc/reports_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/generate_report_button_widget.dart';
import 'model/outstanding_report_model.dart';

@RoutePage()
class ReportOutstandingsPage extends StatefulWidget {
  const ReportOutstandingsPage({super.key});

  @override
  State<ReportOutstandingsPage> createState() => _ReportOutstandingsPageState();
}

class _ReportOutstandingsPageState extends State<ReportOutstandingsPage> {
  _getOutStandingReports() {
    context.read<ReportsBloc>().add(GetOutstandingReports(
        outstandingReportReqParams: OutstandingReportReqParams()));
  }

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
            BlocConsumer<ReportsBloc, ReportsState>(
              listener: (context, state) {
                if (state is OutstandingReportSuccessState) {
                  debugPrint(
                      "Length : ${state.outstandingReportMainResEntity.data?.data?.length}");
                }
              },
              builder: (context, state) {
                return GenerateReportButtonWidget(
                  onpressed: () {
                    _getOutStandingReports();
                  },
                  title: "Generate Report",
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
