import 'package:animoo/core/resources/conts_values.dart';
import 'package:animoo/core/widgets/unKnow_route_page.dart';
import 'package:animoo/view/main_page/category_details/screen/category_details_page.dart';
import 'package:animoo/view/main_page/home/screen/home_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/resources/routes_manager.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: getIt<GlobalKey<NavigatorState>>(
        instanceName: ConstsValuesManager.homePageNavigationState,
      ),
      onGenerateRoute: (settings) {
        Widget widget;
        switch (settings.name) {
          case RoutesName.categoryPageDetails:
            widget = const CategoryDetailsPage();
          case RoutesName.slash:
            widget = const HomePage();
          default:
            widget = const UnknownRoutePage();
        
           
            
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return widget;
          },
        );
      },
    );
  }
}
