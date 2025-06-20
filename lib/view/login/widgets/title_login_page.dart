import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 38.sp,
        color: Colors.black,
        fontFamily: fontsManager.Otama,
      ),
    );
  }
}
