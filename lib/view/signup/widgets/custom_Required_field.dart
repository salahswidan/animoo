import 'package:animoo/core/resources/assets_values_manager.dart';
import 'package:animoo/core/resources/color_manager.dart';
import 'package:animoo/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRequiredField extends StatelessWidget {
  const CustomRequiredField({
    super.key,
    required this.fieldTitle,
    this.formKey,
    this.onPressedAtEye,
    this.visible,
    required this.controller,
    this.validator, this.onChanged,
  });
  final String fieldTitle;

  final GlobalKey<FormState>? formKey;
  final VoidCallback? onPressedAtEye;
  final bool? visible;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            fieldTitle,
            style: TextStyle(
              fontFamily: fontsManager.Poppins,
              color: ColorManager.kGreyColor,
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        CustomTextFormField(
          onChanged: onChanged,
          controller: controller,
          obscureText:
              fieldTitle == "Password" || fieldTitle == "Confirm Password"
                  ? true
                  : false,
          suffixIcon:
              fieldTitle == "Password" || fieldTitle == "Confirm Password"
                  ? IconButton(
                    onPressed: onPressedAtEye,
                    icon: Icon(
                      visible == true ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                  : null,
          hintText: "Enter your ${fieldTitle.toLowerCase()}",
          validator:validator,
          keyboardType:
              fieldTitle == "Password" || fieldTitle == "Confirm Password"
                  ? TextInputType.visiblePassword
                  : TextInputType.emailAddress,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
