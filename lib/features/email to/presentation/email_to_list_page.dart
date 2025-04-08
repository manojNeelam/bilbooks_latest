import 'package:billbooks_app/core/widgets/section_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../invoice/presentation/email_to_page.dart';

class EmailToListPage extends StatelessWidget with SectionAdapterMixin {
  EmailToListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SectionListView.builder(adapter: this),
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    return SizedBox();
  }

  @override
  int numberOfSections() {
    return 2;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return const SectionHeaderWidget(
      title: "CLIENT STAFF",
    );
  }

  @override
  int numberOfItems(int section) {
    return 10;
  }
}
