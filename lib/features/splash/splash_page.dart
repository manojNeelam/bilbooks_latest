import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/utils.dart';
import 'package:billbooks_app/features/dashboard/presentation/bloc/authinfo_bloc.dart';
import 'package:billbooks_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';
import '../dashboard/domain/entity/authinfo_entity.dart';
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
