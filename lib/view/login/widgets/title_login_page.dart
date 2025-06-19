
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';

class TitleLoginPage extends StatelessWidget {
  const TitleLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Log in",
      style: TextStyle(
        fontSize: 38.sp,
        color: Colors.black,
        fontFamily: fontsManager.Otama,
      ),
    );
  }
}
