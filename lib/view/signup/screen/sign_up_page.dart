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
                    onTapAtSelectImage: (){
                      signUpController.onTapAtSelectImage();
                      setState(() {});
                    },
                    
                    fileImage: signUpController.fileImage,
                    onChanged: (value) {
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
                    onPressedAtEyePassword: () {},
                    onPressedAtEyeConfirmPassword: () {},
                  ),

                  App_Button(
                    onTap: () async {
                      if (signUpController.formKey.currentState!.validate()) {
                        // Perform sign-up logic here
                        print("Form is valid");
                        // You can call your API or perform any action here
                      } else {
                        print("Form is invalid");
                      }
                      // var result = InternetCheckerService();
                      // bool isOnline = await result();
                      // print(isOnline);
                      // Dio dio = Dio();
                      // try {
                      //   final response = await dio.post(
                      //     'http://10.0.2.2:8000/api/signup',
                      //     data: {
                      //       "firstName": "salah",
                      //       "lastName": "swidan",
                      //       "email": "ahmed122727727@gmail.com",
                      //       "phone": "201553798716",
                      //       "password": "12345678",
                      //       "imagePath":
                      //           "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/PNG_Test.png/500px-PNG_Test.png",
                      //     },
                      //   );
                      //   print(response);
                      // } catch (e) {
                      //   if (e is DioException) {
                      //     print(e.response?.data);
                      //     print(e.message);
                      //     print(e.error);
                      //   }
                      // }
                    },
                    text: "Sign Up",
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
