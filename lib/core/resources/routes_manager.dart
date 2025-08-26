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
      case RoutesName.forgetPassword:
        widget = ForgetPasswordPage();
      case RoutesName.otpVerificationScreen:
        widget = OtpVerificationPage();
      case RoutesName.createNewPassword:
        widget = CreateNewPasswordPage();
      default:
        widget = const UnknownRoutePage();
    }
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}

class RoutesName {
  static const String loginPage = '/';
  static const String signupPage = '/signup';
  static const String forgetPassword = '/forgetPassword';
  static const String otpVerificationScreen = '/otpVerification';
  static const String createNewPassword = '/createNewPassword';
}
