import 'package:animoo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/assets_values_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.borderRadius = 20,
    this.suffixIcon,
    this.obscureText,  this.validator, this.keyboardType,
  });
  final String? hintText;
  final double borderRadius;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator:validator,
      obscuringCharacter: '*',
      style: TextStyle(color: ColorManager.kPrimaryColor,fontSize: 14.sp),
      obscureText:obscureText ?? false,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: suffixIcon,
        isDense: true,
        fillColor: ColorManager.kwhiteColor,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: fontsManager.Poppins,
          color: ColorManager.kGreyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: ColorManager.kPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
