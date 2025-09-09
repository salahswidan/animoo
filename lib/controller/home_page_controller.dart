import 'package:flutter/material.dart';
import '../core/di/get_it.dart';
import '../core/functions/app_navigations.dart';
import '../core/resources/conts_values.dart';
import '../core/resources/routes_manager.dart';

class HomePageController {
  static HomePageController? _instance;
  HomePageController._internal() {
    debugPrint("TestHomeController");
    //init();
  }

  factory HomePageController() {
    return _instance ??= HomePageController._internal();
  }

  void onPressedAtSeeMore(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = getIt<GlobalKey<NavigatorState>>(
      instanceName: ConstsValuesManager.homePageNavigationState,
    );
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.pushNamed(RoutesName.categoryPageDetails.route);
    } else {
      AppNavigation.pushNamed(context, RoutesName.categoryPageDetails);
    }
  }
}
