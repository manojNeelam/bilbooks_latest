import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/dashboard/domain/entity/session_data.dart';

class HiveFunctions {
  //static final billbooksDatabaseBox = Hive.openBox("billBooks_database_box");
  static const String bbDBNameKey = "billBooks_database_box";
  static const String userSessionDataKey = "user_session_data";

  static Future<void> saveUserSessionData(
      SessionDataEntity sessionDataEntity) async {
    final billbooksDatabaseBox = await Hive.openBox(bbDBNameKey);
    await billbooksDatabaseBox.put(userSessionDataKey, sessionDataEntity);
    final SessionDataEntity? user =
        billbooksDatabaseBox.get(userSessionDataKey);
    debugPrint(
        "XXXXX ${user?.organization?.estimateHeading ?? "no estimate heading"}");
  }

  static Future<SessionDataEntity?> getUserSessionData() async {
    final billbooksDatabaseBox = await Hive.openBox(bbDBNameKey);
    return billbooksDatabaseBox.get(userSessionDataKey);
  }
}
