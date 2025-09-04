import 'package:animoo/core/di/services/get_it.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/animooo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  getItSetup();
  runApp(const AnimoooApp());
}
