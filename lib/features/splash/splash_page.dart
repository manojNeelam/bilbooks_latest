import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/hive_functions.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/authinfo_bloc.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';
import '../../core/utils/column_settings_pref.dart';
import '../dashboard/domain/entity/authinfo_entity.dart';
import '../dashboard/domain/entity/column_settings_data.dart';
import '../dashboard/domain/entity/session_data.dart';
import '../dashboard/domain/usecase/auth_info_usecase.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthInfoMainDataEntity? authInfoMainDataEntity;
  bool ignoreObserving = false;
  BuildContext? splashContext;

  @override
  void initState() {
    splashContext = context;
    _callApi();
    super.initState();
  }

  Future<void> saveEstimateTitle(title) async {
    await Utils.saveEstimate(title);
    var estimateTitle = await Utils.getEstimate();
    debugPrint("estimateTitle: $estimateTitle");
  }

  //ColumnSettingsEntity

  Future<void> saveColumnSettings(ColumnSettingsPref pref) async {
    await Utils.saveColumnSettings(pref);
    ColumnSettingsPref? columnSettingsEntity = await Utils.getColumnSettings();
    debugPrint(columnSettingsEntity?.qty ?? "");
  }

  Future<void> saveUserSessionData(SessionDataEntity sessionDataEntity) async {
    HiveFunctions.saveUserSessionData(sessionDataEntity);
    // final _billBooks_database_box =
    //     await Hive.openBox('billBooks_database_box');
    // await _billBooks_database_box.put('user_session_data', sessionDataEntity);

    // final user = _billBooks_database_box.get('user_session_data');
  }

  Future<void> _callApi() async {
    var token = await Utils.getToken();
    if (token == null) {
      AutoRouter.of(splashContext!)
          .pushAndPopUntil(const LoginPageRoute(), predicate: (_) => false);
    } else {
      splashContext!
          .read<AuthinfoBloc>()
          .add(GetAuthInfoEvent(params: AuthInfoReqParams()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthinfoBloc, AuthinfoState>(
      listener: (context, state) {
        if (state is AuthInfoSuccessState) {
          if (!ignoreObserving) {
            ignoreObserving = true;
            authInfoMainDataEntity = state.authInfoMainResEntity.data;
            var estimateTitle = authInfoMainDataEntity
                ?.sessionData?.organization?.estimateHeading;

            ColumnSettingsEntity? columnSettingsEntity = authInfoMainDataEntity
                ?.sessionData?.organization?.columnSettings;

            ColumnSettingsPref columnSettingsPref = ColumnSettingsPref.fromInfo(
                qty: columnSettingsEntity?.columnUnitsTitle,
                rate: columnSettingsEntity?.columnRateTitle,
                hideQty: columnSettingsEntity?.hideColumnQty,
                itemTitle: columnSettingsEntity?.columnItemsTitle,
                hideRate: columnSettingsEntity?.hideColumnRate);
            saveColumnSettings(columnSettingsPref);

            if (authInfoMainDataEntity?.sessionData != null) {
              bool isUserPremium = false;
              var plan =
                  authInfoMainDataEntity?.sessionData?.organization?.plan;
              isUserPremium = !(plan?.isExpired ?? true);
              Utils.setIsPremiumUser(isPremiumUser: isUserPremium);
              saveUserSessionData(authInfoMainDataEntity!.sessionData!);
            }

            saveEstimateTitle(estimateTitle);
            AutoRouter.of(context).pushAndPopUntil(
                GeneralRoute(authInfoMainDataEntity: authInfoMainDataEntity!),
                predicate: (_) => false);
          }
        } else if (state is AuthInfoErrorState) {
          AutoRouter.of(context)
              .pushAndPopUntil(const LoginPageRoute(), predicate: (_) => false);
        }
      },
      builder: (context, state) {
        return Image.asset(Assets.assetsImagesLaunchscreen);
      },
    );
  }
}
