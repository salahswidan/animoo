import 'package:animoo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, this.hintText,  this.borderRadius  =20, this.suffix});
  final String? hintText;
  final double borderRadius;
  final Widget? suffix;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        suffix: suffix ,
        fillColor: ColorManager.kwhiteColor,
        hintText:hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius.r)),
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
