import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/features/clients/domain/entities/client_list_entity.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceClientDetailsWidget extends StatelessWidget {
  final String emailToVlaue;
  final String? projectValue;
  final ClientEntity? clientEntity;
  final Function()? onTapOpenEmailTo;
  final Function()? onTapOpenSelectClient;
  final Function()? onTapOpenProjects;
  final bool showExchangeRate;
  final String? baseCurrencyCode;
  final String? clientCurrencyCode;
  final TextEditingController? exchangeRateController;
  final ValueChanged<String>? onExchangeRateChanged;
  const InvoiceClientDetailsWidget(
      {super.key,
      this.clientEntity,
      required this.onTapOpenEmailTo,
      required this.onTapOpenProjects,
      required this.onTapOpenSelectClient,
      required this.emailToVlaue,
      this.projectValue,
      this.showExchangeRate = false,
      this.baseCurrencyCode,
      this.clientCurrencyCode,
      this.exchangeRateController,
      this.onExchangeRateChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.horizotal16,
      color: AppPallete.white,
      child: Column(
        children: [
          Padding(
            padding: AppConstants.verticalPadding13,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTapOpenSelectClient,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.people,
                    color: AppPallete.blueColor,
                  ),
                  AppConstants.sizeBoxWidth10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (clientEntity?.name ?? "-").capitalize(),
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.mediumStyle(
                              color: AppPallete.blueColor, size: 16),
                        ),
                        Text(
                          _getAddress(),
                          style:
                              AppFonts.regularStyle(color: AppPallete.k666666),
                        )
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppPallete.borderColor,
                  ),
                ],
              ),
            ),
          ),
          const ItemSeparator(),
          if (showExchangeRate) ...[
            Padding(
              padding: AppConstants.verticalPadding13,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Exchange Rate',
                    style: AppFonts.regularStyle(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            '1 ${clientCurrencyCode ?? ''} =',
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 72,
                          child: TextFormField(
                            controller: exchangeRateController,
                            onChanged: onExchangeRateChanged,
                            textAlign: TextAlign.center,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*')),
                            ],
                            style: AppFonts.mediumStyle(size: 15),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              hintText: '1',
                              hintStyle: AppFonts.hintStyle(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppPallete.borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: AppPallete.blueColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            baseCurrencyCode ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.regularStyle(
                                color: AppPallete.k666666),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const ItemSeparator(),
          ],
          Padding(
            padding: AppConstants.verticalPadding13,
            child: GestureDetector(
              onTap: onTapOpenEmailTo,
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email To",
                    style: AppFonts.regularStyle(),
                  ),
                  Row(
                    children: [
                      Text(
                        emailToVlaue,
                        style: AppFonts.regularStyle(),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppPallete.borderColor,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const ItemSeparator(),
          Padding(
            padding: AppConstants.verticalPadding13,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTapOpenProjects,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Project",
                    style: AppFonts.regularStyle(),
                  ),
                  Row(
                    children: [
                      Text(
                        projectValue ?? "Tap to Select",
                        style: AppFonts.regularStyle(
                            color: projectValue == null
                                ? AppPallete.borderColor
                                : AppPallete.textColor),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppPallete.borderColor,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAddress() {
    String address = '';
    if (clientEntity?.address != null && clientEntity!.address!.isNotEmpty) {
      address += "${clientEntity?.address}";
    } else if (clientEntity?.city != null && clientEntity!.city!.isNotEmpty) {
      address += "${clientEntity?.city}";
    }
    if (clientEntity?.countryName != null &&
        clientEntity!.countryName!.isNotEmpty) {
      String prefix = address.isNotEmpty ? ", " : "";
      address += "$prefix${clientEntity!.countryName}";
    }
    return (address.isNotEmpty ? address : "-").capitalize();
  }
}
