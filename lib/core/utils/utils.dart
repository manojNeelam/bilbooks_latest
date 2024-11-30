import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/utils/column_settings_pref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../router/app_router.dart';

class Utils {
  Utils();

  //MARK: - Private helpers
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  static Future<ColumnSettingsPref?> getColumnSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String columnPrefString = prefs.getString("column_settings_pref") ?? "";
    if (columnPrefString.isNotEmpty) {
      Map<String, dynamic> columnMap = jsonDecode(columnPrefString);
      return ColumnSettingsPref.fromJson(columnMap);
    }
    return null;
  }

  static Future<void> saveColumnSettings(
      ColumnSettingsPref columnSettingsPref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(columnSettingsPref);
    prefs.setString("column_settings_pref", jsonString);
  }

  static Future<String?> getEstimate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("estimateTitle");
  }

  static Future<void> saveEstimate(estimate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("estimateTitle", estimate);
  }

  static Future<void> saveToken(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static showTrailExpired(context) {
    AutoRouter.of(context).push(const PlanExpiredPageRoute());
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
