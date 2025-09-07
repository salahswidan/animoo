import 'dart:io';

import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/colors_manager.dart';
import 'package:animoo/core/widgets/buttons/app_button.dart';
import 'package:animoo/core/widgets/custom_required_field.dart';
import 'package:animoo/core/widgets/spacing/horizontal_space.dart';
import 'package:animoo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/select_image_status.dart';
import '../../../../core/widgets/custom_select_your_image_widget.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Category",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: ColorManager.kPrimaryColor,
                  fontFamily: FontsManager.otamaEpFontFamily,
                ),
              ),
              VerticalSpace(12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundImage: AssetImage(
                      "assets/image/background_splash_screen_undrer_12.png",
                    ),
                  ),
                  HorizontalSpace(6.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Salah Swidan",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorManager.kBlackColor,
                          fontFamily: FontsManager.originalSurferFontFamily,
                        ),
                      ),
                      VerticalSpace(4.h),
                      Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          color: ColorManager.kLightGreenColor.withOpacity(
                            0.10,
                          ),
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.public,
                              size: 10.sp,
                              color: ColorManager.kLightGreenColor,
                            ),
                            HorizontalSpace(3.w),
                            Text(
                              "Public",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: ColorManager.kGreenColor,
                                fontFamily:
                                    FontsManager.originalSurferFontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              VerticalSpace(22.h),
              CustomRequiredField(
                controller: TextEditingController(),
                title: "Category Name",
                hintText: "Enter category name",
                keyboardType: TextInputType.text,
              ),
              VerticalSpace(12.h),

              CustomRequiredField(
                maxLines: 3,
                controller: TextEditingController(),
                title: "Category Description",
                hintText: "Enter category description",
                keyboardType: TextInputType.text,
              ),
              VerticalSpace(12.h),
              Text(
                "Select image category",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorManager.kGrey6Color,
                  fontFamily: FontsManager.poppinsFontFamily,
                ),
              ),
              VerticalSpace(4.h),
              StreamBuilder<File?>(
                stream: Stream.empty(),
                initialData: null,
                builder:
                    (context, snapshot) => CustomSelectImageWidget(
                      file: snapshot.data,
                      onTapAtSelectImage: (value) {},
                      selectImageStatus: SelectImageStatus.noImageSelected,
                    ),
              ),
              VerticalSpace(31.h),
              AppButton(text: "Save", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
