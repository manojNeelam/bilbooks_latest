import 'package:billbooks_app/features/clients/presentation/client_sort_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class ClientTypeHeaderWidget extends StatefulWidget {
  final EnumClientType selectedType;
  final Function(EnumClientType) callBack;
  final Map<EnumClientType, int> counts;

  const ClientTypeHeaderWidget({
    super.key,
    required this.selectedType,
    required this.callBack,
    required this.counts,
  });

  @override
  State<ClientTypeHeaderWidget> createState() => _ClientTypeHeaderWidgetState();
}

class _ClientTypeHeaderWidgetState extends State<ClientTypeHeaderWidget> {
  final ScrollController _scrollController = ScrollController();

  final Map<EnumClientType, GlobalKey> _keys = {
    EnumClientType.all: GlobalKey(),
    EnumClientType.active: GlobalKey(),
    EnumClientType.inactive: GlobalKey(),
    EnumClientType.overdue: GlobalKey(),
  };

  @override
  void didUpdateWidget(covariant ClientTypeHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedType != widget.selectedType) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToItem(widget.selectedType);
      });
    }
  }

  void _scrollToItem(EnumClientType type) {
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

  Color getColorFor(EnumClientType type) {
    return type == widget.selectedType
        ? AppPallete.blueColor
        : AppPallete.clear;
  }

  TextStyle getStyleFor(EnumClientType type) {
    return type == widget.selectedType
        ? AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16)
        : AppFonts.regularStyle(color: AppPallete.textColor, size: 16);
  }

  Widget buildTab(EnumClientType type) {
    final count = widget.counts[type] ?? 0;
    final title = count > 0 ? "${type.title} ($count)" : type.title;

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
      EnumClientType.all,
      EnumClientType.active,
      EnumClientType.inactive,
      EnumClientType.overdue,
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
