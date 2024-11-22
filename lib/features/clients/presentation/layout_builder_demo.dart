import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LayoutBuilderDemo extends StatelessWidget {
  const LayoutBuilderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        //Alert --> go back
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Practice"),
          ),
          body: LayoutBuilder(
            builder: (context, constraint) {
              return Container(
                color: AppPallete.blueColor,
                child: Text(
                  "hello",
                  style: AppFonts.regularStyle(),
                ),
              );
            },
          )),
    );
  }
}
