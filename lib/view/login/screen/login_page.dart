import 'package:animoo/core/resources/routes_manager.dart';
import 'package:animoo/core/widgets/app_logo_and_title_widget.dart';
import 'package:animoo/view/login/widgets/forget_password_login.dart';
import 'package:animoo/view/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/bottons/app_button.dart';
import '../widgets/bottom_nav_bar_login_page.dart';
import '../widgets/title_login_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarLoginPage(
        title: "Sign Up",
        onPressedSignUpNow: () {
          Navigator.pushNamed(context, RoutesName.signupPage);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18).w,
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  AppLogoAndTitleWidget(),
                  SizedBox(height: 9.h),
                  TitlePage(title: "Login"),

                  LoginForm(
                    formKey: GlobalKey(),
                    visible: false,
                    onPressedAtEye: () {},
                  ),
                  ForgetPasswordLogin(onPressedAtForgetPassword: () {}),
                  SizedBox(height: 31.h),
                  App_Button(onTap: () {}, text: "Login"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
