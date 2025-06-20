import 'package:animoo/view/signup/widgets/custom_text_field_with_title.dart';
import 'package:animoo/view/signup/widgets/required_rules_for_password.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/widgets/custom_select_your_image_widget.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.onPressedAtEye,
    this.visible,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback onPressedAtEye;
  final bool? visible;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWithTitle(
            fieldTitle: "Frist Name",
            controller: TextEditingController(),
          ),
          CustomTextFieldWithTitle(
            fieldTitle: "Last Name",
            controller: TextEditingController(),
          ),
          CustomTextFieldWithTitle(
            fieldTitle: "Phone Number",
            controller: TextEditingController(),
          ),
          CustomTextFieldWithTitle(
            fieldTitle: "Email",
            controller: TextEditingController(),
          ),
          CustomTextFieldWithTitle(
            controller: TextEditingController(),
            fieldTitle: "Password",
            onPressedAtEye: onPressedAtEye,
            visible: visible,
          ),
          RequiredRulesForPassword(),
          CustomTextFieldWithTitle(
            controller: TextEditingController(),
            fieldTitle: "Confirm Password",
            onPressedAtEye: onPressedAtEye,
            visible: visible,
          ),
          Text(
            "Upload your profile image",
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorManager.kGreyColor,
              fontFamily: fontsManager.Poppins,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.h),
          CustomSelectImageWidget(),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }
}