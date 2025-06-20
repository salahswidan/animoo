import 'package:animoo/view/login/widgets/title_login_page.dart';
import 'package:animoo/view/signup/widgets/required_rules_for_password.dart';
import 'package:animoo/view/signup/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/app_logo_and_title_widget.dart';
import '../../../core/widgets/bottons/app_button.dart';
import '../../login/widgets/bottom_nav_bar_login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarLoginPage(
        onPressedSignUpNow: () {
          Navigator.pushNamed(context, '/');
        },
        title: "Login",
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
                  TitlePage(title: "Sign Up"),

                  SignUpForm(
                    formKey: GlobalKey(),
                    visible: false,
                    onPressedAtEye: () {},
                  ),

                  App_Button(onTap: () {}, text: "Sign Up"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
