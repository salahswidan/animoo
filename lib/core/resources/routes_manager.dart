import 'package:animoo/view/custom_splash_screen.dart/custom_splash_screen.dart';
import 'package:animoo/view/main_page/screen/main_page.dart';
import 'package:flutter/material.dart';

import '../../view/create_new_password/screens/create_new_password_page.dart';
import '../../view/forget_password/screen/forget_password_page.dart';
import '../../view/login/screen/login_page.dart';
import '../../view/otp_verfication_code/screens/otp_verification_code_page.dart';
import '../../view/signup/screen/sign_up_page.dart';
import '../widgets/unKnow_route_page.dart';

class RoutesManager {
  static Route? onGenerateRoute(RouteSettings settings) {
    Widget widget;
    if (settings.name == RoutesName.loginPage.route) {
      widget = LoginPage();
    } else if (settings.name == RoutesName.signupPage.route) {
      widget = SignUpPage();
    } else if (settings.name == RoutesName.forgetPasswordPage.route) {
      widget = ForgetPasswordPage();
    } else if (settings.name == RoutesName.otpVerificationScreen.route) {
      widget = OtpVerificationPage();
    } else if (settings.name == RoutesName.createNewPassword.route) {
      widget = CreateNewPasswordPage();
    } else if (settings.name == RoutesName.mainPage.route) {
      widget = MainPage();
    } else if (settings.name == RoutesName.customSplashScreen.route) {
      widget = const CustomSplashScreen();
    } else {
      widget = const UnknownRoutePage();
    }
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}

enum RoutesName {
  loginPage("/loginPage"),
  signupPage("/signupPage"),
  forgetPasswordPage("/forgetPasswordPage"),
  otpVerificationScreen("/otpVerificationScreen"),
  createNewPassword("/createNewPassword"),
  mainPage("/mainPage"),
  customSplashScreen("/"),
  categoryPageDetails("/categoryPageDetails"),
  slash("/");

  final String route;
  const RoutesName(this.route);
}
