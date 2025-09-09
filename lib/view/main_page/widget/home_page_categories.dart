import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/spacing/horizontal_space.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class HomePageCategories extends StatelessWidget {
  const HomePageCategories({
    super.key,
    required this.onPressedAddNewCategory,
    required this.onPressedAtSeeMore,
  });
  final VoidCallback onPressedAddNewCategory;
  final VoidCallback onPressedAtSeeMore;

  @override
  Widget build(BuildContext context) {
    int length = 5;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _TitleCategory(
            onPressedAddNewCategory: onPressedAddNewCategory,
          ),
        ),
        VerticalSpace(22.h),
        SizedBox(
          height: 85.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,

            itemBuilder:
                (context, index) =>
                    index == 0
                        ? HorizontalSpace(16.w)
                        : index == length - 1
                        ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 30.w, bottom: 20.w),
                          child: MaterialButton(
                            color: ColorManager.kGreenColor,
                            textColor: ColorManager.kWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            onPressed: onPressedAtSeeMore,
                            child: Text("See More"),
                          ),
                        )
                        : Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 32.r,
                                  backgroundImage: AssetImage(
                                    "assets/image/background_splash_screen_undrer_12.png",
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: -3,
                                  child: Badge.count(
                                    count: 10,
                                    textStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily:
                                          FontsManager.poppinsFontFamily,
                                    ),

                                    padding: EdgeInsets.all(4.r),
                                    backgroundColor: ColorManager.kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Dogs",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: FontsManager.otamaEpFontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
            separatorBuilder: (context, index) => HorizontalSpace(20.w),
            itemCount: length,
          ),
        ),
        VerticalSpace(22.h),
      ],
    );
  }
}

class _TitleCategory extends StatelessWidget {
  const _TitleCategory({required this.onPressedAddNewCategory});

  final VoidCallback onPressedAddNewCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Categories ( 20 )",
            style: TextStyle(
              fontFamily: FontsManager.poppinsFontFamily,
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: onPressedAddNewCategory,
            child: Text(
              "Add New Category ",
              style: TextStyle(
                fontFamily: FontsManager.otamaEpFontFamily,
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
