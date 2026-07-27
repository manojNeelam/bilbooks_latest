import 'package:flutter/material.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';
import 'preferences_page.dart';

class PreferencesTypeHeaderWidget extends StatefulWidget {
  final EnumPreferencesType selectedType;
  final Function(EnumPreferencesType) callBack;
  const PreferencesTypeHeaderWidget({
    super.key,
    required this.selectedType,
    required this.callBack,
  });

  @override
  State<PreferencesTypeHeaderWidget> createState() =>
      _PreferencesTypeHeaderWidgetState();
}

class _PreferencesTypeHeaderWidgetState
    extends State<PreferencesTypeHeaderWidget> {
  final ScrollController _scrollController = ScrollController();
  static const double _horizontalPadding = 12;
  static const double _tabSpacing = 8;
  static const double _tabHorizontalInset = 12;
  double _viewportWidth = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PreferencesTypeHeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _measureTabWidth(EnumPreferencesType type) {
    final textPainter = TextPainter(
      text: TextSpan(text: type.title, style: getStyleFor(type)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width + (_tabHorizontalInset * 2);
  }

  void _scrollToType(EnumPreferencesType selectedType, double viewportWidth) {
    if (!_scrollController.hasClients) {
      return;
    }

    double leadingWidth = _horizontalPadding;
    for (final type in EnumPreferencesType.values) {
      final currentWidth = _measureTabWidth(type);
      if (type == selectedType) {
        final centeredOffset =
            leadingWidth + (currentWidth / 2) - (viewportWidth / 2);
        final targetOffset = centeredOffset.clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );
        _scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
        return;
      }
      leadingWidth += currentWidth + _tabSpacing;
    }
  }

  Color getColorFor(EnumPreferencesType type) {
    return type == widget.selectedType
        ? AppPallete.blueColor
        : AppPallete.clear;
  }

  TextStyle getStyleFor(EnumPreferencesType type) {
    return type == widget.selectedType
        ? AppFonts.regularStyle(color: AppPallete.blueColor, size: 16)
        : AppFonts.regularStyle(color: AppPallete.textColor, size: 16);
  }

  Widget _buildTab(EnumPreferencesType type) {
    return Container(
      margin: const EdgeInsets.only(right: _tabSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: _tabHorizontalInset,
                vertical: 8,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              if (_viewportWidth > 0) {
                _scrollToType(type, _viewportWidth);
              }
              widget.callBack(type);
            },
            child: Text(
              type.title,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: getStyleFor(type),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: 2,
            width: double.infinity,
            color: getColorFor(type),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _viewportWidth = constraints.maxWidth;

        return Column(
          children: [
            SizedBox(
              height: 44,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                itemCount: EnumPreferencesType.values.length,
                itemBuilder: (context, index) {
                  final type = EnumPreferencesType.values[index];
                  return _buildTab(type);
                },
              ),
            ),
            const ItemSeparator(),
          ],
        );
      },
    );
  }
}
