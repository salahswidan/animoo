import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/color_manager.dart';
import 'package:animoo/core/resources/routes_manager.dart';
import 'package:animoo/core/widgets/bottons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_bar/simple_app_bar.dart';
import '../../signup/widgets/custom_text_field_with_title.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Back"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 9.h),

                Text(
                  "Forget Your Password ?",
                  style: TextStyle(
                    fontFamily: fontsManager.Otama,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    "Please enter the email address associated with your account, and we\'ll send you OTP to reset your password",
                    style: TextStyle(
                      fontFamily: fontsManager.Poppins,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kGrey4Color,
                    ),
                  ),
                ),
                SizedBox(height: 58.h),
                CustomTextFieldWithTitle(
                  controller: TextEditingController(),
                  fieldTitle: "Email",
                ),
                SizedBox(height: 135.h),
                App_Button(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(RoutesName.otpVerficationCodePage);
                  },
                  text: "Send Code",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
