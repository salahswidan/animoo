import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../widgets/bottons/app_button.dart';

Future<void> showSelectImageModalBottomSheet(BuildContext context, void Function() onTapAtCamera, void Function() onTapAtGallery)async {
   await showModalBottomSheet(
  
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            App_Button(
              onTap: onTapAtCamera,
              text: "Camera",
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.r),
                topRight: Radius.circular(5.r),
              ),
              backgroundColor: Colors.white,
              textColor: ColorManager.kPrimaryColor,
              fontSize: 18.sp,
              height: 61.h,
            ),
            Divider(color: Colors.white, height: 1.h),
            App_Button(
              onTap: onTapAtGallery,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5.r),
                bottomRight: Radius.circular(5.r),
              ),
              text: "Gallery",
              backgroundColor: Colors.white,
              textColor: ColorManager.kPrimaryColor,
              fontSize: 18.sp,
              height: 61.h,
            ),
            SizedBox(height: 10.h),
            App_Button(
              onTap: () {
                Navigator.pop(context);
              },
              text: "Cancel",
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5.r),
                bottomRight: Radius.circular(5.r),
              ),
              backgroundColor: Colors.white,
              textColor: ColorManager.kPrimaryColor,
              fontSize: 18.sp,
              height: 61.h,
            ),
          ],
        );
      },
    );
  }