import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String title;
  const LoadingPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator.adaptive(),
              AppConstants.sizeBoxWidth10,
              Text(
                title,
                style: AppFonts.regularStyle(),
              )
            ],
          )
        ],
      ),
    );
  }
}
