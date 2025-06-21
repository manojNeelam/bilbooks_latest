import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/main.dart';
import 'package:flutter/material.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_page.dart';
import '../../domain/entity/overdue_invoice_entity.dart';
import '../../domain/usecase/overdue_invoice_usecase.dart';
import '../bloc/overdueinvoice_bloc.dart';

class OverdueInvoceWidget extends StatefulWidget {
  final OverdueInvoiceBuilder builder;

  const OverdueInvoceWidget({super.key, required this.builder});

  @override
  State<OverdueInvoceWidget> createState() => _OverdueInvoceWidgetState();
}

class _OverdueInvoceWidgetState extends State<OverdueInvoceWidget> {
  List<DashboardInvoiceEntity> overDueInvoices = [];
  int maxCount() {
    return overDueInvoices.length > 4 ? 4 : overDueInvoices.length;
  }

  double getSeeMoreHeight() {
    return (overDueInvoices.length > 4) ? 100 : 0;
  }

  @override
  void initState() {
    _callApi();
    super.initState();
  }

  void _callApi() {
    context
        .read<OverdueinvoiceBloc>()
        .add(GetOverdueInvoicesEvent(params: OverdueInvoiceUsecaseReqParams()));
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, _callApi);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          boxShadow: AppConstants.dashBoardItemSadow,
          borderRadius: BorderRadius.circular(5),
          color: AppPallete.white),
      child: BlocConsumer<OverdueinvoiceBloc, OverdueinvoiceState>(
        listener: (context, state) {
          if (state is OverdueInvoicesSuccessState) {
            overDueInvoices =
                state.overdueInvoiceMainResEntity.data?.invoices ?? [];
          }
        },
        builder: (context, state) {
          if (state is OverdueInvoicesLoadingState) {
            return const SizedBox(
                height: 100,
                child: LoadingPage(title: "Loading Overdue invoice"));
          }

          if (state is OverdueInvoicesSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Overdue Invoices".toUpperCase(),
                  style: AppFonts.regularStyle(),
                ),
                AppConstants.sizeBoxHeight10,
                SizedBox(
                  height: maxCount() > 0 ? (65.0 * maxCount()) : 30,
                  child: (maxCount() > 0)
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: maxCount(),
                          itemBuilder: (context, index) {
                            final invoice = overDueInvoices[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            invoice.clientName ?? "",
                                            style: AppFonts.regularStyle(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        AppConstants.sizeBoxWidth15,
                                        Text(
                                          invoice.balance ?? "",
                                          style: AppFonts.mediumStyle(
                                              color: AppPallete.red, size: 16),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          invoice.no ?? "",
                                          style: AppFonts.regularStyle(
                                              color: AppPallete.k666666,
                                              size: 14),
                                        ),
                                        Text(
                                          invoice.date ?? "",
                                          style: AppFonts.regularStyle(
                                              color: AppPallete.k666666,
                                              size: 14),
                                        )
                                      ],
                                    ),
                                  ]),
                                ),
                                if (maxCount() > index + 1)
                                  const ItemSeparator(),
                              ],
                            );
                          })
                      : Text(
                          "No overdue invoices to display",
                          style:
                              AppFonts.regularStyle(color: AppPallete.k666666),
                        ),
                ),
                if (overDueInvoices.length > 4)
                  GestureDetector(
                    child: Text(
                      "See more",
                      style: AppFonts.regularStyle(color: AppPallete.blueColor)
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
              ],
            );
          }
          return const SizedBox(
            height: 300,
            width: 400,
          );
        },
      ),
    );
  }
}
