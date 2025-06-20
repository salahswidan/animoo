import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart';

class ForgetPasswordLogin extends StatelessWidget {
  const ForgetPasswordLogin({
    super.key,
    required this.onPressedAtForgetPassword,
  });
  final VoidCallback onPressedAtForgetPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -10,
            right: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onPressedAtForgetPassword,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    color: ColorManager.kPrimaryColor,
                    fontSize: 10.sp,
                    fontFamily: fontsManager.Poppins,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
