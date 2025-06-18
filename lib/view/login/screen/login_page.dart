import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/color_manager.dart';
import 'package:animoo/core/widgets/app_logo_and_title_widget.dart';
import 'package:animoo/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18).w,
            child: Column(
              children: [
                AppLogoAndTitleWidget(),
                SizedBox(height: 9.h),
                Text(
                  "Log in",
                  style: TextStyle(
                    fontSize: 38.sp,
                    color: Colors.black,
                    fontFamily: fontsManager.Otama,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontFamily: fontsManager.Poppins,
                      color: ColorManager.kGreyColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(hintText: "Enter your email"),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontFamily: fontsManager.Poppins,
                      color: ColorManager.kGreyColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  hintText: "Enter your password",
                  suffix: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye),
                  ),
                ),
                SizedBox(height: 12.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          fontFamily: fontsManager.Poppins,
                          color: ColorManager.kGreyColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            print("object");
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontFamily: fontsManager.Poppins,
                              color: ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
