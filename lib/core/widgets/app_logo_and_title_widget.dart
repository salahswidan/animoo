
import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoAndTitleWidget extends StatelessWidget {
  const AppLogoAndTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
               SvgPicture.asset(AssetsValuesManager.appLogoSVG, width: 72.w),
              Text(
                'Animoo',
                style: TextStyle(
                  fontFamily: fontsManager.originalSurfer,
                  fontSize: 12.sp,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
      ],
    );
  }
}
