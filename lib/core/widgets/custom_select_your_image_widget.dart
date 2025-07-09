import 'dart:io';

import 'package:animoo/core/enums/select_image_status.dart';
import 'package:animoo/core/resources/color_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/assets_values_manager.dart';

class CustomSelectImageWidget extends StatelessWidget {
  const CustomSelectImageWidget({
    super.key,
    this.file,
    required this.onTapAtSelectImage,
    required this.selectImageStatus,
  });
  final File? file;
  final GestureTapCallback onTapAtSelectImage;
  final SelectImageStatus selectImageStatus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapAtSelectImage,
      child:
          file == null
              ? noFoundImage(selectImageStatus: selectImageStatus)
              : FoundImage(file: file!, selectImageStatus: selectImageStatus),
    );
  }
}

class FoundImage extends StatelessWidget {
  const FoundImage({
    super.key,
    required this.file,
    required this.selectImageStatus,
  });
  final File file;
  final SelectImageStatus selectImageStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          // padding: EdgeInsets.symmetric(vertical: 67.w, horizontal: 20.h),
          radius: Radius.circular(10.r),
          color:
              selectImageStatus == SelectImageStatus.normal
                  ? ColorManager.kPrimaryColor
                  : selectImageStatus == SelectImageStatus.noImageSelected
                  ? Colors.red
                  : Colors.green,
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SizedBox(width: double.infinity, child: Image.file(file)),
        ),
      ),
    );
  }
}

class noFoundImage extends StatelessWidget {
  const noFoundImage({super.key, required this.selectImageStatus});
  final SelectImageStatus selectImageStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          padding: EdgeInsets.symmetric(vertical: 67.w, horizontal: 20.h),
          radius: Radius.circular(10.r),
          color:
              selectImageStatus == SelectImageStatus.normal
                  ? ColorManager.kPrimaryColor
                  : selectImageStatus == SelectImageStatus.noImageSelected
                  ? Colors.red
                  : Colors.green,
        ),

        child: SizedBox(
          height: 100.h,

          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color:
                    selectImageStatus == SelectImageStatus.normal
                        ? ColorManager.kPrimaryColor
                        : selectImageStatus == SelectImageStatus.noImageSelected
                        ? Colors.red
                        : Colors.green,
                size: 28.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                "Select Your Image",
                style: TextStyle(
                  color:
                      selectImageStatus == SelectImageStatus.normal
                          ? ColorManager.kPrimaryColor
                          : selectImageStatus ==
                              SelectImageStatus.noImageSelected
                          ? Colors.red
                          : Colors.green,
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
