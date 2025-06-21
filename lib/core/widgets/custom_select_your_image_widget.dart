import 'package:animoo/core/resources/color_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/assets_values_manager.dart';

class CustomSelectImageWidget extends StatelessWidget {
  const CustomSelectImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          padding: EdgeInsets.symmetric(vertical: 67.w, horizontal: 20.h),
          radius: Radius.circular(10.r),
          color: ColorManager.kPrimaryColor,
        ),
    
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: ColorManager.kPrimaryColor,
                size: 28.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                "Select File",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: fontsManager.Poppins,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
