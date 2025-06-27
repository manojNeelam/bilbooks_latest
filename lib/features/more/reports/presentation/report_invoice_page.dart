import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_dropdown_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/generate_report_button_widget.dart';
import 'bloc/reports_bloc.dart';
import 'model/invoice_report_model.dart' show InvoiceReportReqPrarams;

@RoutePage()
class ReportInvoicePage extends StatefulWidget {
  const ReportInvoicePage({super.key});

  @override
  State<ReportInvoicePage> createState() => _ReportInvoicePageState();
}

class _ReportInvoicePageState extends State<ReportInvoicePage> {
  _getInvoiceReports() {
    context.read<ReportsBloc>().add(
        GetInvoiceReports(invoiceReportReqPrarams: InvoiceReportReqPrarams()));
  }

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
            BlocConsumer<ReportsBloc, ReportsState>(
              listener: (context, state) {
                if (state is InvoiceReportSuccessState) {
                  debugPrint(
                      "Length : ${state.invoiceReportMainResEntity.data?.data?.length}");
                }
              },
              builder: (context, state) {
                return GenerateReportButtonWidget(
                  onpressed: () {
                    _getInvoiceReports();
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
