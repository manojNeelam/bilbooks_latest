import 'package:billbooks_app/core/constants/assets.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.white,
      child: Center(
        child: Image.asset(
          Assets.assetsImagesBillbooksHeader,
          width: 193,
          height: 35,
        ),
      ),
    );
  }
}
