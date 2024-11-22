import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/item_separator.dart';
import 'dart:math' as math;

class ClientItemWidget extends StatelessWidget {
  final ClientEntity clientEntity;
  final ClientEntity? selectedClientEntity;

  const ClientItemWidget(
      {super.key, required this.clientEntity, this.selectedClientEntity});

  @override
  Widget build(BuildContext context) {
    Color color =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: AppPallete.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                      border: Border.all(color: color, width: 1),
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      _getClientFirstCharacter(),
                      style: AppFonts.mediumStyle(color: color, size: 16),
                    ),
                  ),
                ),
                AppConstants.sizeBoxWidth5,
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getClientName(),
                          style: AppFonts.regularStyle(
                              color: AppPallete.black, size: 16),
                        ),
                        Row(
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                _getAddress(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.regularStyle(
                                    size: 14, color: AppPallete.k666666),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (_isActive() == false && _getStatus().isNotEmpty)
                              CapsuleStatusWidget(
                                  title: _getStatus(),
                                  backgroundColor: AppPallete.kF2F2F2,
                                  textColor: AppPallete.k666666)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (isClientSelected())
                  const Icon(
                    Icons.check,
                    color: AppPallete.blueColor,
                  )
              ],
            ),
          ),
          const ItemSeparator(),
        ],
      ),
    );
  }

  bool isClientSelected() {
    if (selectedClientEntity == null) {
      return false;
    }
    if (clientEntity.id != null && selectedClientEntity?.id != null) {
      return clientEntity.id == selectedClientEntity?.id;
    }
    if (clientEntity.clientId != null &&
        selectedClientEntity?.clientId != null) {
      return clientEntity.clientId == selectedClientEntity?.clientId;
    }
    return false;
  }

  bool _isActive() {
    if (clientEntity.status != null && clientEntity.status!.isNotEmpty) {
      if (clientEntity.status == "1") {
        return true;
      }
    }
    return false;
  }

  String _getStatus() {
    if (clientEntity.status != null && clientEntity.status!.isNotEmpty) {
      if (clientEntity.status == "1") {
        return "Active";
      } else {
        return "Inactive";
      }
    }
    return "";
  }

  String _getAddress() {
    String address = '';
    if (clientEntity.address != null && clientEntity.address!.isNotEmpty) {
      address += "${clientEntity.address}";
    } else if (clientEntity.city != null && clientEntity.city!.isNotEmpty) {
      address += "${clientEntity.city}";
    }
    if (clientEntity.countryName != null &&
        clientEntity.countryName!.isNotEmpty) {
      String prefix = address.isNotEmpty ? ", " : "";
      address += "$prefix${clientEntity.countryName}";
    }
    return address.isNotEmpty ? address.capitalize() : "-";
  }

  String _getClientFirstCharacter() {
    if (clientEntity.name != null && clientEntity.name!.isNotEmpty) {
      return clientEntity.name![0].capitalize();
    }
    return "";
  }

  String _getClientName() {
    return (clientEntity.name ?? "").capitalize();
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
