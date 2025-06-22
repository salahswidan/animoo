import 'package:animoo/core/widgets/app_bar/simple_app_bar.dart';
import 'package:animoo/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/widgets/bottons/app_button.dart';
import '../../../core/widgets/verfication/aoo_otp_verification_text_field.dart';

class OtpVerficationCodePage extends StatelessWidget {
  const OtpVerficationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Cancel"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 9.h),

                Text(
                  "Otp Verification",
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
                    "Please enter the 4 digit code sent to your email address",
                    style: TextStyle(
                      fontFamily: fontsManager.Poppins,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kGrey4Color,
                    ),
                  ),
                ),
                SizedBox(height: 41.h),
                AppOtpVerificationTextField(
                  onCompleted: (value) {
                    Navigator.of(
                      context,
                    ).pushNamed(RoutesName.createNewPasswordPage);
                  },
                ),

                SizedBox(height: 41.h),
                App_Button(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(RoutesName.createNewPasswordPage);
                  },
                  text: "Confirm",
                ),
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Resend Code in 00:59",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: fontsManager.Poppins,
                      fontWeight: FontWeight.w600,
                    ),
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
