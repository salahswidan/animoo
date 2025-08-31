import 'package:animoo/controller/login_screen_controller.dart';
import 'package:animoo/core/widgets/loading/app_madel_progress_hud.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginScreenController _loginScreenController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _loginScreenController = LoginScreenController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppModelProgressHud(
        loadingOutputStream: _loginScreenController.loadingScreenStateOutputStream,
        child: SafeArea(
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
                      onChanged: _loginScreenController.onChangeTextField,
                      emailController: _loginScreenController.emailController,
                      passwordController:
                          _loginScreenController.passwordController,
                      formKey: _loginScreenController.loginFormKey,
                      onPressedAtEye: _loginScreenController.onPressedAtEye,
                      eyeVisibleOutPutStream:
                          _loginScreenController.eyeVisibleOutPutStream,
                    ),
                    ForgetPasswordLogin(
                      onPressedAtForgetPassword: () =>
                          _loginScreenController.onPressedAtForgetPassword(),
                    ),
        
                    AppButton(text: ConstsValuesManager.login,
                    buttonStatusOutputStream: _loginScreenController.loginButtonStatusOutputStream,
                     onTap: _loginScreenController.onPressedAtLoginButton),
                  ],
                ),
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
