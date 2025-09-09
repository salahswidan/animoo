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
    switch (settings.name) {
      case RoutesName.loginPage:
        widget = LoginPage();
      case RoutesName.signupPage:
        widget = SignUpPage();
      case RoutesName.forgetPasswordPage:
        widget = ForgetPasswordPage();
      case RoutesName.otpVerificationScreen:
        widget = OtpVerificationPage();
      case RoutesName.createNewPassword:
        widget = CreateNewPasswordPage();
      case RoutesName.mainPage:
        widget = MainPage();
      case RoutesName.customSplashScreen:
        widget = const CustomSplashScreen();
      default:
        widget = const UnknownRoutePage();
    }
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}

class RoutesName {
  RoutesName._();
  static const String loginPage = '/loginPage';
  static const String signupPage = '/signup';
  static const String forgetPasswordPage = '/forgetPassword';
  static const String otpVerificationScreen = '/otpVerification';
  static const String createNewPassword = '/createNewPassword';

  static const String mainPage = '/mainPage';
   static const String customSplashScreen = '/';

  static const String categoryPageDetails = '/categoryPageDetails';

  static const String slash = '/';
}
