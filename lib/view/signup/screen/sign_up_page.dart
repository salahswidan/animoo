import 'package:animoo/controller/sign_up_controller.dart';
import 'package:animoo/core/resources/const_values.dart';
import 'package:animoo/core/services/inernet_checker_service.dart';
import 'package:animoo/view/login/widgets/title_login_page.dart';
import 'package:animoo/view/signup/widgets/required_rules_for_password.dart';
import 'package:animoo/view/signup/widgets/sign_up_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/app_logo_and_title_widget.dart';
import '../../../core/widgets/bottons/app_button.dart';
import '../../login/widgets/bottom_nav_bar_login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpController signUpController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpController = SignUpController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    signUpController.disposeControllers();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarLoginPage(
        onPressedSignUpNow: () {
          Navigator.of(context).pop();
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
                    onChanged: (value) {
                      signUpController.onChanged(value);
                      setState(() {});
                    },
                    selectImageStatus: signUpController.selectImageStatus,
                    onTapAtSelectImage: () {
                      signUpController.onTapAtSelectImage();
                      setState(() {});
                    },

                    fileImage: signUpController.fileImage,
                    onChangedPassword: (value) {
                      signUpController.onChangedPassword(value);

                      setState(() {});
                      //   //   print(value);
                      //   // signUpController.passwordController.text = value;
                      //   // print(signUpController.passwordController.text);
                    },
                    firstNameController: signUpController.firstNameController,
                    lastNameController: signUpController.lastNameController,
                    emailController: signUpController.emailController,
                    passwordController: signUpController.passwordController,
                    confirmPasswordController:
                        signUpController.confirmPasswordController,
                    formKey: signUpController.formKey,
                    visiblePassword: signUpController.visiblePassword,
                    visibleConfirmPassword:
                        signUpController.visibleConfirmPassword,
                    onPressedAtEyePassword: (){
                      signUpController.onPressedAtEyePassword();
                      setState(() {});
                    },
                    onPressedAtEyeConfirmPassword: () {
                      signUpController.onPressedAtEyeConfirmPassword();
                      setState(() {});
                    },
                  ),

                  App_Button(
                    text: "Sign Up",
                    onTap:
                        signUpController.signUpActive == true
                            ? () async {
                              signUpController.onTapSignUp();
                              setState(() {});
                            }
                            : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
