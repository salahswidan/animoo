import 'package:animoo/core/database/hive/hive_helper.dart';
import 'package:animoo/core/di/get_it.dart';
import 'package:animoo/core/resources/conts_values.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/animooo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
   HiveHelper hiveHelper = HiveHelper(ConstsValuesManager.rememberMeBoxName);
   var rememberMe = await hiveHelper.getValue(key: ConstsValuesManager.rememberMe);
   print(rememberMe);
  getItSetup();
  runApp(const AnimoooApp());
}
