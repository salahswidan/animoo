import 'package:animoo/core/resources/conts_values.dart';
import 'package:animoo/core/widgets/unKnow_route_page.dart';
import 'package:animoo/view/main_page/category_details/screen/category_details_page.dart';
import 'package:animoo/view/main_page/home/screen/home_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/resources/routes_manager.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build home tap');
    return Navigator(
      key: getIt<GlobalKey<NavigatorState>>(
        instanceName: ConstsValuesManager.homePageNavigationState,
      ),
      onGenerateRoute: (settings) {
        print(settings.name);
        Widget widget;
        if (settings.name == RoutesName.categoryPageDetails.route) {
          widget = const CategoryDetailsPage();
        } else if (settings.name == RoutesName.slash.route) {
          widget = const HomePage();
        } else {
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
