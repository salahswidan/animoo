import 'package:animoo/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class AnimooApp extends StatelessWidget {
  const AnimooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:RoutesManager.onGenerateRoute,
    );
  }

 
}