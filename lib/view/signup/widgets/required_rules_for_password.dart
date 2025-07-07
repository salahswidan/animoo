import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/const_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequiredRulesForPassword extends StatelessWidget {
  const RequiredRulesForPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ConstsListManager.passwordRulesRequirements.any(
          (element) => element['valid'] == false,
        ))
          Text(
            "Please add all necessary characters to create safe password",
            style: TextStyle(
              color: Colors.red,
              fontSize: 10.sp,
              fontFamily: fontsManager.Poppins,
              fontWeight: FontWeight.w700,
            ),
          ),
        SizedBox(height: 11.h),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ConstsListManager.passwordRulesRequirements.length,
          itemBuilder: (context, index) {
            bool isValid =
                ConstsListManager.passwordRulesRequirements[index]['valid'];
            return RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: Icon(Icons.circle, color: Colors.green, size: 5.sp),
                  ),
                  WidgetSpan(child: SizedBox(width: 2.w)),
                  TextSpan(
                    text:
                        ConstsListManager
                            .passwordRulesRequirements[index]['title'],
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                      color: isValid == true ? Colors.green : Colors.red,
                      fontFamily: fontsManager.Poppins,
                      decoration:
                          isValid == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 5.h),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
