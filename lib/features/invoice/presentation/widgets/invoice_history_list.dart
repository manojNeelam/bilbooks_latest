import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:billbooks_app/features/invoice/presentation/widgets/history_item_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class InvoiceHistoryList extends StatelessWidget {
  final List<InvoiceHistoryEntity> historyList;
  const InvoiceHistoryList({
    super.key,
    required this.historyList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        bottom: AppConstants.getAppBarDivider,
      ),
      body: ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            final item = historyList[index];
            return HistoryItemWidget(historyEntity: item);
          }),
    );
  }
}
