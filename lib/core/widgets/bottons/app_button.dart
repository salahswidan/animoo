import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class App_Button extends StatelessWidget {
  const App_Button({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.height,
    this.textColor, this.fontSize, this.borderRadius,
  });
  final void Function()? onTap;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 14.sp,
            fontFamily: fontsManager.Poppins,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, height ?? 44.h),
          backgroundColor: backgroundColor ?? ColorManager.kPrimaryColor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius:borderRadius ?? BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
