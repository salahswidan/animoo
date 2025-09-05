
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/widgets/app_logo_widget.dart';
import '../../../core/widgets/spacing/horizontal_space.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          AppLogoWidget(),
          HorizontalSpace(24.w),
          Text(
            "Hello In Animoo",
            style: TextStyle(
              fontSize: 24.sp,
              fontFamily: FontsManager.originalSurferFontFamily,
              color: ColorManager.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
