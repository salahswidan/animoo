import 'package:animoo/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimooApp extends StatelessWidget {
  const AnimooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return
        MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.onGenerateRoute,
        );
      },
    );
  }
}
