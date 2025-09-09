import 'package:flutter/material.dart';
import '../core/resources/routes_manager.dart';

class HomePageController {
  static HomePageController? _instance;
  HomePageController._internal() {
    print("TestHomeController");
    //init();
  }

  factory HomePageController() {
    return _instance ??= HomePageController._internal();
  }

  void onPressedAtSeeMore(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.categoryPageDetails);
    
  }
}
