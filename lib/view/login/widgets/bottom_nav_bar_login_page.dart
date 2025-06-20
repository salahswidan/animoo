import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart' show ColorManager;

class BottomNavBarLoginPage extends StatelessWidget {
  const BottomNavBarLoginPage({
    super.key,
    required this.onPressedSignUpNow,
    required this.title,
  });
  final void Function() onPressedSignUpNow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    fontFamily: fontsManager.Poppins,
                    color: ColorManager.kGreyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),

                WidgetSpan(child: SizedBox(width: 4.w)),
                WidgetSpan(
                  child: InkWell(
                    onTap: onPressedSignUpNow,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: fontsManager.Poppins,
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                WidgetSpan(child: SizedBox(height: 20.h)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
