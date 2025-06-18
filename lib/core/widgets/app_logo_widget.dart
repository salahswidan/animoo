
import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsValuesManager.appLogoSVG, width: 72.w);
  }
}