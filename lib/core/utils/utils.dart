import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../router/app_router.dart';

class Utils {
  Utils();

  //MARK: - Private helpers
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  static Future<void> saveToken(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  // static Future<void> manipulateLogin(context) async {
  //   var token = await getToken();
  //   if (token != null) {
  //     AutoRouter.of(context).push(const GeneralRoute());
  //   } else {
  //     AutoRouter.of(context).push(const OnBoardRoute());
  //   }
  // }

  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
