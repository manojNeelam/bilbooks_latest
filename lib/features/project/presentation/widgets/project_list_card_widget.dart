import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/project_list_entity.dart';

class ProjectListCardWidget extends StatelessWidget {
  final ProjectEntity projectEntity;
  final bool isSelected;
  const ProjectListCardWidget(
      {super.key, required this.projectEntity, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppConstants.verticalPadding,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        projectEntity.name?.capitalize() ?? "",
                        textAlign: TextAlign.start,
                        style: AppFonts.regularStyle(),
                      ),
                      Text(
                        projectEntity.clientName ?? "",
                        textAlign: TextAlign.start,
                        style: AppFonts.regularStyle(
                            color: AppPallete.k666666, size: 14),
                      ),
                    ],
                  ),
                ),
                Text(
                  _getStatusText(),
                  style: AppFonts.regularStyle(
                      size: 14,
                      color:
                          _isActive() ? AppPallete.greenColor : AppPallete.red),
                )
              ],
            ),
          ),
          const ItemSeparator()
        ],
      ),
    );
  }

  bool _isActive() {
    if (projectEntity.status?.toLowerCase() == "active") {
      return true;
    }
    return false;
  }

  String _getStatusText() {
    if (_isActive()) {
      return "ACTIVE";
    }
    return "INACTIVE";
  }
}
