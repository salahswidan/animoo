import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class HomePageAnimals extends StatelessWidget {
  const HomePageAnimals({
    super.key,
    required this.onPressedAddNewCategory,
    required this.onPressedAtSeeMore,
  });
  final VoidCallback onPressedAddNewCategory;
  final VoidCallback onPressedAtSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _TitleAnimal(onPressedAddNewAnimal: onPressedAddNewCategory),
        ),
        VerticalSpace(13.h),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => _AnimalCard(),
          separatorBuilder: (context, index) => VerticalSpace(17.h),
          itemCount: 5,
        ),
      ],
    );
  }
}

class _AnimalCard extends StatelessWidget {
  const _AnimalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: ColorManager.kLightWhiteColor,
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dog name",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontsManager.otamaEpFontFamily,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Created by Salah Swidan",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: FontsManager.poppinsFontFamily,
                        color: ColorManager.kGrey5Color,
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "1000\$",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontsManager.poppinsFontFamily,
                          color: ColorManager.kGrey5Color,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(Icons.more_vert_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/image/background_splash_screen_undrer_12.png",
            height: 173.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.w,
              right: 8.0.w,
              bottom: 5.h,
              top: 12.h,
            ),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontsManager.poppinsFontFamily,
                color: ColorManager.kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAnimal extends StatelessWidget {
  const _TitleAnimal({required this.onPressedAddNewAnimal});

  final VoidCallback onPressedAddNewAnimal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Animals ( 20 )",
            style: TextStyle(
              fontFamily: FontsManager.poppinsFontFamily,
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: onPressedAddNewAnimal,
            child: Text(
              "Add New Animal ",
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
