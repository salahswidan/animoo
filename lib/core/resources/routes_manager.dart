import 'package:animoo/core/widgets/unKnow_route_page.dart';
import 'package:animoo/view/forget_password/screen/forget_password_page.dart';
import 'package:animoo/view/login/screen/login_page.dart';
import 'package:animoo/view/signup/screen/sign_up_page.dart';
import 'package:flutter/material.dart';

class RoutesManager {
static  Route? onGenerateRoute(RouteSettings settings) {
    Widget widget;
    switch (settings.name) {
      case RoutesName.loginPage:
        widget = LoginPage();
      case RoutesName.signupPage:
        widget = SignUpPage();
      case RoutesName.forgetPasswordPage:
        widget = ForgetPasswordPage();
      default:
        widget = const UnknowRoutePage();

    }
    return MaterialPageRoute(builder: (context) =>widget,settings: settings);

  }
}

class RoutesName {
  static const String loginPage = '/';
  static const String signupPage = '/signupPage';
  static const String forgetPasswordPage = '/forgetPasswordPage';
}
