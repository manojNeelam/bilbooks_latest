import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/invoice/domain/entities/invoice_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../../core/widgets/section_header_widget.dart';

@RoutePage()
class EmailToPage extends StatefulWidget {
  final List<EmailtoMystaffEntity> myStaffList;
  final List<EmailtoMystaffEntity> clientStaff;
  final List<EmailtoMystaffEntity> selectedMyStaffList;
  final List<EmailtoMystaffEntity> selectedClientStaff;
  final Function(List<EmailtoMystaffEntity> myStaffList,
      List<EmailtoMystaffEntity> clientStaffList) onpressDone;
  const EmailToPage(
      {super.key,
      required this.clientStaff,
      required this.myStaffList,
      required this.selectedClientStaff,
      required this.selectedMyStaffList,
      required this.onpressDone});

  @override
  State<EmailToPage> createState() => _EmailToPageState();
}

class _EmailToPageState extends State<EmailToPage> with SectionAdapterMixin {
  List<EmailtoMystaffEntity> myStaffList = [];
  List<EmailtoMystaffEntity> clientStaff = [];
  List<EmailtoMystaffEntity> selectedMyStaffList = [];
  List<EmailtoMystaffEntity> selectedClientStaff = [];

  @override
  void initState() {
    myStaffList = widget.myStaffList;
    clientStaff = widget.clientStaff;
    selectedMyStaffList = widget.selectedMyStaffList;
    selectedClientStaff = widget.selectedClientStaff;
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
                debugPrint(
                    "Selected My Staff Count: ${selectedMyStaffList.length}");
                debugPrint(
                    "Selected Client Staff Count: ${selectedClientStaff.length}");
                widget.onpressDone(selectedMyStaffList, selectedClientStaff);
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
    if (indexPath.section == 0) {
      final item = clientStaff[indexPath.item];
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
    final item = myStaffList[indexPath.item];
    return EmailToItemWidget(
      name: item.name ?? "",
      email: item.email ?? "",
      id: item.id ?? "",
      onPressItem: (id) {
        updateSelectedMyStaff(item);
        setState(() {});
      },
      isSelected: checkIsMyStaffAlreadySelected(item.id ?? ""),
    );
  }

  bool checkIsMyStaffAlreadySelected(String id) {
    return selectedMyStaffList.where(
      (returnedMyStaff) {
        return id == returnedMyStaff.id;
      },
    ).isNotEmpty;
  }

  void updateSelectedMyStaff(EmailtoMystaffEntity item) {
    if (checkIsMyStaffAlreadySelected(item.id ?? "")) {
      selectedMyStaffList.remove(item);
    } else {
      selectedMyStaffList.add(item);
    }
  }

  bool checkIsClientStaffAlreadySelected(String? id) {
    if (id == null || selectedClientStaff.isEmpty) {
      return false;
    }
    return selectedClientStaff.where(
      (returnedClientStaff) {
        return id == returnedClientStaff.id;
      },
    ).isNotEmpty;
  }

  void updateSelectedClientStaff(EmailtoMystaffEntity item) {
    if (checkIsClientStaffAlreadySelected(item.id)) {
      selectedClientStaff.remove(item);
    } else {
      selectedClientStaff.add(item);
    }
  }

  @override
  int numberOfItems(int section) {
    if (section == 0) {
      return clientStaff.length;
    }
    return myStaffList.length;
  }

  @override
  int numberOfSections() {
    return 2;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return Container(
        color: AppPallete.white,
        child: SectionHeaderWidget(
            title: section == 0 ? "Client Staff" : "My Staff"));
  }

  @override
  bool shouldExistSectionHeader(int section) {
    if (section == 0) {
      return clientStaff.isNotEmpty;
    }
    if (section == 1) {
      return myStaffList.isNotEmpty;
    }
    return false;
  }
}

class EmailToItemWidget extends StatelessWidget {
  const EmailToItemWidget(
      {super.key,
      required this.name,
      required this.email,
      required this.id,
      required this.onPressItem,
      required this.isSelected});

  final bool isSelected;
  final String name;
  final String email;
  final String id;
  final Function(String) onPressItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onPressItem(id);
      },
      child: Container(
        padding: AppConstants.horizotal16,
        color: AppPallete.white,
        child: Column(
          children: [
            Padding(
              padding: AppConstants.verticalPadding13,
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? AppPallete.blueColor
                        : AppPallete.borderColor,
                  ),
                  AppConstants.sizeBoxWidth10,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          style: AppFonts.regularStyle(),
                        ),
                        Text(
                          email,
                          style: AppFonts.regularStyle(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const ItemSeparator(),
          ],
        ),
      ),
    );
  }
}
