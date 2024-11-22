import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/client_item_widget.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../core/app_constants.dart';
import '../../../core/constants/assets.dart';
import '../../dashboard/domain/entity/authinfo_entity.dart';

enum EnumScreentype {
  preference,
  users,
  taxes,
  integrations,
  emailtemplate;
}

extension EnumScreentypeExtension on EnumScreentype {
  (String image, String title) get details {
    switch (this) {
      case EnumScreentype.preference:
        return (Assets.assetsImagesIcSettingsPreferences, "Preferences");
      case EnumScreentype.users:
        return (Assets.assetsImagesIcSettingsUsers, "User");
      case EnumScreentype.taxes:
        return (Assets.assetsImagesIcTaxesSettings, "Taxes");
      case EnumScreentype.integrations:
        return (Assets.assetsImagesIcSettingsIntegrations, "Integration");
      case EnumScreentype.emailtemplate:
        return (Assets.assetsImagesIcSettingsEmailTemplate, "Email Templates");
    }
  }
}

@RoutePage()
class SettingsPage extends StatelessWidget {
  final AuthInfoMainDataEntity authInfoMainDataEntity;
  const SettingsPage({super.key, required this.authInfoMainDataEntity});

  (bool, String) getRenewText() {
    var plan = authInfoMainDataEntity.sessionData?.organization?.plan;
    if (plan == null) {
      return (true, "Expired");
    }
    var isPlanExpired = plan.isExpired ?? true;
    var expiresIn = int.parse(plan.days ?? "0");
    if (isPlanExpired) {
      return (true, "Expired");
    }
    if (expiresIn > 0) {
      return (false, "Expires in $expiresIn days");
    } else if (expiresIn == 0) {
      return (false, "Expires today");
    }
    return (true, "Expired");
  }

  @override
  Widget build(BuildContext context) {
    List<EnumScreentype> settingsList = [
      EnumScreentype.preference,
      EnumScreentype.users,
      EnumScreentype.taxes,
      EnumScreentype.integrations,
      EnumScreentype.emailtemplate
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppPallete.blueColor,
          ),
          onPressed: () {
            AutoRouter.of(context).maybePop();
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                AutoRouter.of(context)
                    .push(const OrganizationProfilePageRoute());
              },
              child: Text(
                "Edit",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
        backgroundColor: AppPallete.lightBlueColor,
        title: const Text(
          "Settings",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppPallete.lightBlueColor,
            padding: AppConstants.horizontalVerticalPadding,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.assetsImagesIcWebwingz,
                    height: 40,
                  ),
                  AppConstants.sizeBoxHeight15,
                  Text(
                    (authInfoMainDataEntity.sessionData?.organization?.name ??
                            "")
                        .toUpperCase(),
                    style: AppFonts.mediumStyle(size: 19),
                  ),
                  AppConstants.sepSizeBox5,
                  Text(
                    authInfoMainDataEntity
                            .sessionData?.organization?.plan?.name ??
                        "",
                    style: AppFonts.regularStyle(
                        color: AppPallete.k666666, size: 15),
                  ),
                  AppConstants.sepSizeBox5,
                  Text(
                    getRenewText().$2,
                    style: AppFonts.regularStyle(
                        color: getRenewText().$1
                            ? AppPallete.red
                            : AppPallete.greenColor,
                        size: 14),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: AppConstants.horizontalVerticalPadding,
              child: ListView.builder(
                  itemCount: settingsList.length,
                  itemBuilder: (contet, index) {
                    final settingEnumType = settingsList[index];
                    final (imageName, title) = settingEnumType.details;
                    return GestureDetector(
                      onTap: () {
                        switch (settingEnumType) {
                          case EnumScreentype.preference:
                            debugPrint("onTap Preferences");
                            AutoRouter.of(context)
                                .push(const PreferencesPageRoute());
                          case EnumScreentype.users:
                            debugPrint("onTap Users");
                            AutoRouter.of(context).push(UsersListPageRoute());
                          case EnumScreentype.integrations:
                            debugPrint("onTap Integrations");
                            AutoRouter.of(context)
                                .push(const OnlinePaymentsPageRoute());
                          case EnumScreentype.emailtemplate:
                            debugPrint("onTap Email Template");
                            AutoRouter.of(context)
                                .push(const EmailTemplatePageRoute());
                          case EnumScreentype.taxes:
                            debugPrint("onTap Taxes");
                            AutoRouter.of(context)
                                .push(const TaxesListPageRoute());
                        }
                      },
                      child: SettingsItemWidget(
                          imageName: imageName, title: title),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.imageName,
    required this.title,
  });

  final String imageName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.verticalPadding10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imageName,
            width: 25,
            height: 25,
          ),
          AppConstants.sizeBoxWidth15,
          Expanded(
            child: Text(
              title,
              style: AppFonts.regularStyle(),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppPallete.borderColor,
          ),
        ],
      ),
    );
  }
}
