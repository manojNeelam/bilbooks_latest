import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/item_separator.dart';
import '../project_sort_page.dart';

class ProjectTypeHeaderWidget extends StatelessWidget {
  final EnumProjectType selectedType;
  final Function(EnumProjectType) callBack;

  const ProjectTypeHeaderWidget(
      {super.key, required this.selectedType, required this.callBack});

  @override
  Widget build(BuildContext context) {
    const EnumProjectType all = EnumProjectType.all;
    const EnumProjectType active = EnumProjectType.active;
    const EnumProjectType inactive = EnumProjectType.inactive;

    Color getColorFor(EnumProjectType type) {
      return type == selectedType ? AppPallete.blueColor : AppPallete.clear;
    }

    TextStyle getStyleFor(EnumProjectType type) {
      return type == selectedType
          ? AppFonts.mediumStyle(color: AppPallete.blueColor, size: 16)
          : AppFonts.regularStyle(color: AppPallete.textColor, size: 16);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(all);
                        },
                        child: Text(
                          all.title,
                          style: getStyleFor(all),
                        )),
                    Container(
                      height: 2,
                      color: getColorFor(all),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        callBack(active);
                      },
                      child: Text(active.title, style: getStyleFor(active)),
                    ),
                    Container(
                      height: 2,
                      color: getColorFor(active),
                    )
                  ],
                ),
              ),
              AppConstants.sizeBoxWidth5,
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          callBack(inactive);
                        },
                        child:
                            Text(inactive.title, style: getStyleFor(inactive))),
                    Container(
                      height: 2,
                      color: getColorFor(inactive),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const ItemSeparator()
      ],
    );
  }
}
