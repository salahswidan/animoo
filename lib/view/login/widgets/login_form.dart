import 'package:animoo/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(
                fontFamily: fontsManager.Poppins,
                color: ColorManager.kGreyColor,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: "Enter your email",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(
                fontFamily: fontsManager.Poppins,
                color: ColorManager.kGreyColor,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          CustomTextFormField(
            controller: TextEditingController(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            hintText: "Enter your password",
            suffixIcon: IconButton(
              onPressed: onPressedAtEye,
              icon: Icon(
                visible == true ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
