import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/constants/assets.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_section_list/flutter_section_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/utils.dart';
import '../dashboard/domain/entity/authinfo_entity.dart';

@RoutePage()
class MorePage extends StatelessWidget with SectionAdapterMixin {
  final AuthInfoMainDataEntity authInfoMainDataEntity;
  MorePage({super.key, required this.authInfoMainDataEntity});

  List<MoreSectionModel> moreList = [
    //First
    MoreSectionModel(title: "", isShowSection: false, items: [
      MoreItemModel(
          name: "Expenses",
          imageName: Assets.assetsImagesIcExpenses,
          enumMoreScreen: EnumMoreScreen.expenses),
      MoreItemModel(
          name: "Items",
          imageName: Assets.assetsImagesIcItem,
          enumMoreScreen: EnumMoreScreen.items),
      MoreItemModel(
          name: "Projects",
          imageName: Assets.assetsImagesIcProject,
          enumMoreScreen: EnumMoreScreen.projects),
      MoreItemModel(
          name: "Reports",
          imageName: Assets.assetsImagesIcReports,
          enumMoreScreen: EnumMoreScreen.reports),
    ]),

    //Second
    MoreSectionModel(title: "Account", items: [
      MoreItemModel(
          name: "Settings",
          imageName: Assets.assetsImagesIcSettings,
          enumMoreScreen: EnumMoreScreen.settings),
      MoreItemModel(
          name: "Logout",
          imageName: Assets.assetsImagesIcLogout,
          showArrowIcon: false,
          enumMoreScreen: EnumMoreScreen.logout),
    ]),
    MoreSectionModel(title: "Support & Feedback", items: [
      MoreItemModel(
          name: "FAQ",
          imageName: Assets.assetsImagesIcFaq,
          enumMoreScreen: EnumMoreScreen.faq),
      MoreItemModel(
          name: "Contact Us",
          imageName: Assets.assetsImagesIcCall,
          enumMoreScreen: EnumMoreScreen.contactus),
      MoreItemModel(
          name: "Rate Our app",
          imageName: Assets.assetsImagesIcRateUs,
          enumMoreScreen: EnumMoreScreen.rateOurApp),
    ]),
    MoreSectionModel(title: "Others", items: [
      MoreItemModel(
          name: "Privacy Policy",
          imageName: Assets.assetsImagesIcPrivacyPolicy,
          enumMoreScreen: EnumMoreScreen.privacyPolicy),
      MoreItemModel(
          name: "Terms of Service",
          imageName: Assets.assetsImagesIcTerms,
          enumMoreScreen: EnumMoreScreen.terms),
      MoreItemModel(
          name: "Security",
          imageName: Assets.assetsImagesIcSecurity,
          enumMoreScreen: EnumMoreScreen.security),
      MoreItemModel(
          name: "Visit our Website",
          imageName: Assets.assetsImagesIcVisitWebsite,
          enumMoreScreen: EnumMoreScreen.visitOurWebiste),
    ]),
  ];

  openUrlFor(EnumMoreScreen type) async {
    if (type.url != null) {
      final Uri url = Uri.parse(type.url!);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  void _logout(BuildContext context) async {
    await Utils.clearAll();
    AutoRouter.of(context)
        .pushAndPopUntil(const LoginPageRoute(), predicate: (_) => false);
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item = moreList[indexPath.section].items[indexPath.item];

    item.enumMoreScreen;

    return GestureDetector(
      onTap: () {
        switch (item.enumMoreScreen) {
          //Section 1
          case EnumMoreScreen.expenses:
            debugPrint("Tapped Expenses");
            AutoRouter.of(context).push(const ExpensesListPageRoute());
          case EnumMoreScreen.items:
            debugPrint("Tapped items");
            AutoRouter.of(context).push(const ItemListRoute());
          case EnumMoreScreen.projects:
            debugPrint("Tapped projects");
            AutoRouter.of(context).push(ProjectListPageRoute());
          case EnumMoreScreen.reports:
            debugPrint("Tapped reports");
            AutoRouter.of(context).push(const MoreReportsPageRoute());
          //Section 2
          case EnumMoreScreen.settings:
            debugPrint("Tapped settings");

            AutoRouter.of(context).push(SettingsPageRoute(
                authInfoMainDataEntity: authInfoMainDataEntity));

          case EnumMoreScreen.logout:
            debugPrint("Tapped logout");
            _logout(context);

          case EnumMoreScreen.rateOurApp:
            debugPrint("Tapped rateOurApp");

          case EnumMoreScreen.faq ||
                EnumMoreScreen.contactus ||
                EnumMoreScreen.privacyPolicy ||
                EnumMoreScreen.security ||
                EnumMoreScreen.visitOurWebiste ||
                EnumMoreScreen.terms:
            openUrlFor(item.enumMoreScreen);
        }
      },
      child: Container(
        padding: AppConstants.verticalPadding10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              item.imageName,
              height: 25,
              width: 25,
            ),
            AppConstants.sizeBoxWidth15,
            Expanded(
              child: Text(
                item.name,
                textAlign: TextAlign.start,
                style: AppFonts.regularStyle(),
              ),
            ),
            if (item.showArrowIcon)
              const Icon(
                Icons.chevron_right,
                color: AppPallete.borderColor,
              )
          ],
        ),
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    return moreList[section].items.length;
  }

  @override
  int numberOfSections() {
    return moreList.length;
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return moreList[section].isShowSection;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    final sectionTitle = moreList[section].title;

    return Container(
      color: AppPallete.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: Text(
          sectionTitle,
          style: AppFonts.regularStyle(size: 14, color: AppPallete.textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: ItemSeparator(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SectionListView.builder(adapter: this),
      ),
    );
  }
}

class MoreSectionModel {
  String title;
  bool isShowSection;
  List<MoreItemModel> items;

  MoreSectionModel(
      {required this.title, this.isShowSection = true, required this.items});
}

class MoreItemModel {
  String name;
  String imageName;
  bool showArrowIcon;
  EnumMoreScreen enumMoreScreen;

  MoreItemModel(
      {required this.name,
      required this.imageName,
      this.showArrowIcon = true,
      required this.enumMoreScreen});
}

enum EnumMoreScreen {
  expenses,
  items,
  projects,
  reports,
  settings,
  logout,
  faq,
  contactus,
  rateOurApp,
  privacyPolicy,
  terms,
  security,
  visitOurWebiste
}

extension EnumMoreScreenExtension on EnumMoreScreen {
  String? get url {
    const defaultUrl = "https://www.google.com";
    switch (this) {
      case EnumMoreScreen.expenses ||
            EnumMoreScreen.items ||
            EnumMoreScreen.projects ||
            EnumMoreScreen.logout ||
            EnumMoreScreen.reports ||
            EnumMoreScreen.settings:
        return null;
      case EnumMoreScreen.faq:
        return defaultUrl;
      case EnumMoreScreen.rateOurApp:
        return defaultUrl;
      case EnumMoreScreen.contactus:
        return defaultUrl;
      case EnumMoreScreen.privacyPolicy:
        return defaultUrl;
      case EnumMoreScreen.terms:
        return defaultUrl;
      case EnumMoreScreen.security:
        return defaultUrl;
      case EnumMoreScreen.visitOurWebiste:
        return defaultUrl;
    }
  }
}
