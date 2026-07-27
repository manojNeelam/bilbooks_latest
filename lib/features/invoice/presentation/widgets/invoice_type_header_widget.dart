import 'package:billbooks_app/features/invoice/presentation/invoice_list_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';

class InvoiceTypeHeaderWidget extends StatefulWidget {
  final EnumInvoiceType selectedType;
  final Function(EnumInvoiceType) callBack;
  final Map<EnumInvoiceType, int> counts;

  const InvoiceTypeHeaderWidget({
    super.key,
    required this.selectedType,
    required this.callBack,
    required this.counts,
  });

  @override
  State<InvoiceTypeHeaderWidget> createState() =>
      _InvoiceTypeHeaderWidgetState();
}

class _InvoiceTypeHeaderWidgetState extends State<InvoiceTypeHeaderWidget> {
  final ScrollController _scrollController = ScrollController();

  final Map<EnumInvoiceType, GlobalKey> _keys = {
    EnumInvoiceType.all: GlobalKey(),
    EnumInvoiceType.draft: GlobalKey(),
    EnumInvoiceType.unpaid: GlobalKey(),
    EnumInvoiceType.paid: GlobalKey(),
  };

  @override
  void didUpdateWidget(covariant InvoiceTypeHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Auto scroll when selectedType changes
    if (oldWidget.selectedType != widget.selectedType) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToItem(widget.selectedType);
      });
    }
  }

  void _scrollToItem(EnumInvoiceType type) {
    final context = _keys[type]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        alignment: 0.5, // center
        curve: Curves.easeInOut,
      );
    }
  }

  Color getColorFor(EnumInvoiceType type) {
    return type == widget.selectedType
        ? AppPallete.blueColor
        : AppPallete.clear;
  }

  TextStyle getStyleFor(EnumInvoiceType type) {
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

  Widget buildTab(EnumInvoiceType type) {
    final count = widget.counts[type];

    // ✅ No (0) initially
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
                _scrollToItem(type); // ✅ auto scroll on tap
              },
              child: Text(
                title,
                style: getStyleFor(type),
              ),
            ),
            Container(
              height: 3,
              width: double.infinity, // ✅ matches text width
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
      EnumInvoiceType.all,
      EnumInvoiceType.draft,
      EnumInvoiceType.unpaid,
      EnumInvoiceType.paid,
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
