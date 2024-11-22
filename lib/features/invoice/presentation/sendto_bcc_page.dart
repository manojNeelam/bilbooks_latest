import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/features/invoice/domain/entities/get_document_entity.dart';
import 'package:billbooks_app/features/invoice/presentation/email_to_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../../core/app_constants.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_pallete.dart';

@RoutePage()
class SendtoBccPage extends StatefulWidget {
  final List<ContactEntity> list;
  final List<ContactEntity> selectedList;

  final Function(List<ContactEntity> contactList) onpressDone;
  const SendtoBccPage(
      {super.key,
      required this.onpressDone,
      required this.list,
      required this.selectedList});

  @override
  State<SendtoBccPage> createState() => _SendtoBccPageState();
}

class _SendtoBccPageState extends State<SendtoBccPage>
    with SectionAdapterMixin {
  List<ContactEntity> list = [];
  List<ContactEntity> selectedList = [];

  @override
  void initState() {
    list = widget.list;
    selectedList = widget.selectedList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email To"),
        actions: [
          TextButton(
              onPressed: () {
                widget.onpressDone(selectedList);
                AutoRouter.of(context).maybePop();
              },
              child: Text(
                "Done",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        bottom: AppConstants.getAppBarDivider,
      ),
      body: SectionListView.builder(adapter: this),
    );
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = list[indexPath.item];
    return EmailToItemWidget(
      name: item.name ?? "",
      email: item.email ?? "",
      id: item.id ?? "",
      onPressItem: (id) {
        updateSelectedClientStaff(item);
        setState(() {});
      },
      isSelected: checkIsClientStaffAlreadySelected(item.id ?? ""),
    );
  }

  bool checkIsClientStaffAlreadySelected(String? id) {
    if (id == null || selectedList.isEmpty) {
      return false;
    }
    return selectedList.where(
      (returnedClientStaff) {
        return id == returnedClientStaff.id;
      },
    ).isNotEmpty;
  }

  void updateSelectedClientStaff(ContactEntity item) {
    if (checkIsClientStaffAlreadySelected(item.id)) {
      selectedList.remove(item);
    } else {
      selectedList.add(item);
    }
  }

  @override
  int numberOfItems(int section) {
    return list.length;
  }

  @override
  int numberOfSections() {
    return 1;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return false;
  }
}
