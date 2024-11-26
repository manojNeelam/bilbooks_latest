// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:billbooks_app/core/constants/assets.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';

enum EnumSettingTemplateType { invoice, estimate }

@RoutePage()
class SettingTemplatePage extends StatefulWidget {
  final EnumSettingTemplateType enumSettingTemplateType;
  SettingTemplatePage({
    Key? key,
    required this.enumSettingTemplateType,
  }) : super(key: key);

  @override
  State<SettingTemplatePage> createState() => _SettingTemplatePageState();
}

class _SettingTemplatePageState extends State<SettingTemplatePage> {
  PageController pageController = PageController(initialPage: 0);

  int _activePage = 0;
  List<TemplateModel> templateList = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() {
    templateList = [
      TemplateModel(
          imageName:
              widget.enumSettingTemplateType == EnumSettingTemplateType.invoice
                  ? Assets.assetsImagesInvoiceClassic
                  : Assets.assetsImagesEstimateClassic,
          title: "Classic"),
      TemplateModel(
          imageName:
              widget.enumSettingTemplateType == EnumSettingTemplateType.invoice
                  ? Assets.assetsImagesInvoiceModern
                  : Assets.assetsImagesEstimateModern,
          title: "Modern"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        title: Text("Template"),
        automaticallyImplyLeading: false,
        actions: [
          if (_activePage == 0)
            TextButton(
                onPressed: () {
                  AutoRouter.of(context).maybePop();
                },
                child: Text(
                  "Done",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                ))
        ],
      ),
      body: Stack(children: [
        PageView.builder(
            scrollBehavior: CupertinoScrollBehavior(),
            itemCount: templateList.length,
            controller: pageController,
            onPageChanged: (int page) {
              _activePage = page;
              setState(() {});
            },
            itemBuilder: (BuildContext context, int index) {
              TemplateModel templateModel = templateList[index];
              return Column(
                children: [
                  AppConstants.sizeBoxHeight10,
                  Image.asset(
                    templateModel.imageName,
                    width: MediaQuery.of(context).size.width - 80,
                  ),
                  AppConstants.sizeBoxHeight10,
                  Text(
                    templateModel.title,
                    style: AppFonts.regularStyle(),
                  )
                ],
              );
            }),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(templateList.length, (index) {
                return InkWell(
                  onTap: () {
                    debugPrint(index.toString());
                    debugPrint("Current page: ${pageController.page}");

                    _activePage = index;

                    pageController.animateToPage(index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: _activePage == index
                          ? AppPallete.blueColor
                          : AppPallete.blueColor50,
                    ),
                  ),
                );
              }),
            ))
      ]),
    );
  }
}

class TemplateModel {
  final String imageName;
  final String title;
  TemplateModel({required this.imageName, required this.title});
}


/*
PageView(
          controller: PageController(),
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset(
                      enumSettingTemplateType == EnumSettingTemplateType.invoice
                          ? Assets.assetsImagesInvoiceClassic
                          : Assets.assetsImagesEstimateClassic),
                ),
                Text("Classic")
              ],
            ),
            Column(
              children: [
                Container(
                  child: Image.asset(
                      enumSettingTemplateType == EnumSettingTemplateType.invoice
                          ? Assets.assetsImagesInvoiceModern
                          : Assets.assetsImagesEstimateModern),
                ),
                Text("Modern")
              ],
            ),
          ],
*/