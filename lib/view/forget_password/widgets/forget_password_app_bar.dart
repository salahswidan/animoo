import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart';

class ForgetPasswordAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ForgetPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leadingWidth: 38.w,
      title: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "Back",
          style: TextStyle(
            fontSize: 20.sp,
            color: ColorManager.kPrimaryColor,
            fontFamily: fontsManager.Otama,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 4),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            ();
          },
          icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
