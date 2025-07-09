
import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class App_Button extends StatelessWidget {
  const App_Button({
    super.key, required this.onTap, required this.text,
  });
    final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:onTap,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: fontsManager.Poppins,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.kPrimaryColor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
