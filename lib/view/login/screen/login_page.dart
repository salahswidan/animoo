
import 'package:flutter/material.dart';

import '../../../core/resources/conts_values.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/widgets/app_logo_and_title_widget.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../widgets/bottom_nav_bar_login_page.dart';
import '../widgets/forget_password_login.dart';
import '../widgets/login_form.dart';
import '../widgets/title_login_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw18),
              child: Column(
                children: [
                  AppLogoAndTitleWidget(),
                  VerticalSpace(HeightsManager.h9_15),
                  TitleLoginPage(),

                  LoginForm(
                    formKey: GlobalKey(),
                    onPressedAtEye: () {},
                    visible: true, //TODO:: add form key
                  ),
                  ForgetPasswordLogin(
                    onPressedAtForgetPassword: () => Navigator.of(
                      context,
                    ).pushNamed(RoutesName.forgetPassword),
                  ),

                  AppButton(text: ConstsValuesManager.login, onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarLoginPage(
        onPressedSignUpNow: () {
          Navigator.pushNamed(context, RoutesName.signupPage);
        },
      ),
    );
  }
}
