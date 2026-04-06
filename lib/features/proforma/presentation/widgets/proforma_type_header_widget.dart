import 'package:flutter/material.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

enum EnumProformaType {
  all,
  draft,
  sent,
  approved,
  declined,
}

extension EnumProformaTypeExtension on EnumProformaType {
  String get apiParams {
    switch (this) {
      case EnumProformaType.all:
        return "";
      case EnumProformaType.draft:
        return "draft";
      case EnumProformaType.sent:
        return "sent";
      case EnumProformaType.approved:
        return "approved";
      case EnumProformaType.declined:
        return "declined";
    }
  }

  String get title {
    switch (this) {
      case EnumProformaType.all:
        return "All";
      case EnumProformaType.draft:
        return "Draft";
      case EnumProformaType.sent:
        return "Sent";
      case EnumProformaType.approved:
        return "Approved";
      case EnumProformaType.declined:
        return "Declined";
    }
  }
}

class ProformaTypeHeaderWidget extends StatefulWidget {
  final EnumProformaType selectedType;
  final Function(EnumProformaType) callBack;
  final Map<EnumProformaType, int> counts;

  const ProformaTypeHeaderWidget({
    super.key,
    required this.selectedType,
    required this.callBack,
    required this.counts,
  });

  @override
  State<ProformaTypeHeaderWidget> createState() =>
      _ProformaTypeHeaderWidgetState();
}

class _ProformaTypeHeaderWidgetState extends State<ProformaTypeHeaderWidget> {
  final ScrollController _scrollController = ScrollController();

  final Map<EnumProformaType, GlobalKey> _keys = {
    EnumProformaType.all: GlobalKey(),
    EnumProformaType.draft: GlobalKey(),
    EnumProformaType.sent: GlobalKey(),
    EnumProformaType.approved: GlobalKey(),
    EnumProformaType.declined: GlobalKey(),
  };

  @override
  void didUpdateWidget(covariant ProformaTypeHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Auto scroll when selectedType changes
    if (oldWidget.selectedType != widget.selectedType) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToItem(widget.selectedType);
      });
    }
  }

  void _scrollToItem(EnumProformaType type) {
    final context = _keys[type]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        alignment: 0.5,
        curve: Curves.easeInOut,
      );
    }
  }

  Color getColorFor(EnumProformaType type) {
    return type == widget.selectedType
        ? AppPallete.blueColor
        : AppPallete.clear;
  }

  TextStyle getStyleFor(EnumProformaType type) {
    return type == widget.selectedType
        ? AppFonts.mediumStyle(
            color: AppPallete.blueColor,
            size: 16,
          )
        : AppFonts.regularStyle(
            color: AppPallete.textColor,
            size: 16,
          );
  }

  Widget buildTab(EnumProformaType type) {
    final count = widget.counts[type];
    final title = count != null ? "${type.title} ($count)" : type.title;

    return Padding(
      key: _keys[type],
      padding: const EdgeInsets.only(right: 12),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                widget.callBack(type);
                _scrollToItem(type);
              },
              child: Text(
                title,
                style: getStyleFor(type),
              ),
            ),
            Container(
              height: 3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: getColorFor(type),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final types = [
      EnumProformaType.all,
      EnumProformaType.draft,
      EnumProformaType.sent,
      EnumProformaType.approved,
      EnumProformaType.declined,
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: types.map((type) => buildTab(type)).toList(),
            ),
          ),
        ),
        const ItemSeparator(),
      ],
    );
  }
}
