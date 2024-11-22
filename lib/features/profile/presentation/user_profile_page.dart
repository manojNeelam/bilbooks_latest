import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/cap_status_widget.dart';
import 'package:billbooks_app/core/widgets/item_separator.dart';
import 'package:billbooks_app/core/widgets/loading_page.dart';
import 'package:billbooks_app/features/profile/domain/usecase/profile_usecase.dart';
import 'package:billbooks_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_section_list/flutter_section_list.dart';

import '../../dashboard/domain/entity/authinfo_entity.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  final AuthInfoMainDataEntity? authInfoMainDataEntity;
  final Function() refresh;
  const UserProfilePage({
    super.key,
    required this.authInfoMainDataEntity,
    required this.refresh,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SectionAdapterMixin {
  AuthInfoMainDataEntity? authInfoMainDataEntity;
  bool isRefreshonPop = false;

  @override
  void initState() {
    debugPrint("initState");
    authInfoMainDataEntity = widget.authInfoMainDataEntity;
    super.initState();
  }

  void _callApi(String id) {
    context.read<ProfileBloc>().add(SetOrganizationEvent(
        selectOrganizationReqParams: SelectOrganizationReqParams(id: id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.lightBlueColor,
        leading: IconButton(
            onPressed: () {
              if (isRefreshonPop) {
                widget.refresh();
              }
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(
              Icons.close,
              color: AppPallete.blueColor,
            )),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is SelectOrganizationSuccessState) {
            isRefreshonPop = true;
            authInfoMainDataEntity = state.authInfoMainResEntity.data;
            setState(() {});
          }
        },
        builder: (context, state) {
          if (state is SelectOrganizationLoadingState) {
            return const LoadingPage(title: "Setting oragnization...");
          }
          return SectionListView.builder(adapter: this);
        },
      ),
    );
  }

  @override
  bool shouldExistSectionHeader(int section) {
    return true;
  }

  @override
  Widget getSectionHeader(BuildContext context, int section) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        color: AppPallete.lightBlueColor,
        padding: AppConstants.horizontalVerticalPadding,
        child: Row(
          children: [
            Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppPallete.blueColor),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.person,
                  color: AppPallete.lightBlueColor,
                )),
            AppConstants.sizeBoxWidth10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (authInfoMainDataEntity?.sessionData?.user?.name ?? "")
                        .replaceFirst(" ", ""),
                    style: AppFonts.regularStyle(size: 16),
                  ),
                  Text(
                    widget.authInfoMainDataEntity?.sessionData?.user?.email ??
                        "",
                    style: AppFonts.regularStyle(
                        color: AppPallete.k666666, size: 14),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            AutoRouter.of(context).push(
                                UpdateUserProfilePageRoute(
                                    authInfoMainDataEntity:
                                        authInfoMainDataEntity));
                          },
                          child: Text(
                            "My Profile",
                            style: AppFonts.regularStyle(
                                color: AppPallete.blueColor),
                          )),
                      Container(
                        color: AppPallete.k666666,
                        height: 20,
                        width: 1,
                      ),
                      TextButton(
                          onPressed: () async {},
                          child: Text(
                            "Logout",
                            style: AppFonts.regularStyle(color: AppPallete.red),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      AppConstants.sizeBoxHeight10,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "MY ORGANIZATIONS",
          style: AppFonts.regularStyle(color: AppPallete.k666666),
        ),
      ),
      AppConstants.sizeBoxHeight10
    ]);
  }

  @override
  Widget getItem(BuildContext context, IndexPath indexPath) {
    final item =
        authInfoMainDataEntity?.sessionData?.companies?[indexPath.item];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if ((item?.selected ?? false) == false) {
          _callApi(item?.id ?? "");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.name ?? "",
                          style: AppFonts.regularStyle(
                              color: AppPallete.blueColor),
                        ),
                        Text(
                          item?.plan ?? "",
                          style: AppFonts.regularStyle(
                              color: AppPallete.k666666, size: 14),
                        ),
                        AppConstants.sepSizeBox5,
                        CapsuleStatusWidget(
                            title: "Renews in ${item?.planDays ?? ""} days",
                            backgroundColor: AppPallete.white,
                            hasborder: true,
                            textColor: (item?.planIsexpired ?? false)
                                ? AppPallete.red
                                : AppPallete.greenColor)
                      ],
                    ),
                  ),
                  if (item?.selected ?? false)
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
      ),
    );
  }

  @override
  int numberOfItems(int section) {
    return authInfoMainDataEntity?.sessionData?.companies?.length ?? 0;
  }
}
