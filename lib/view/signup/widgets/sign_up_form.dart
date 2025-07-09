import 'dart:io';

import 'package:animoo/core/functions/app_vaildators.dart';
import 'package:animoo/core/functions/image_picker_service.dart';
import 'package:animoo/core/resources/extensions.dart';
import 'package:animoo/view/signup/widgets/coustom_required_confirm_password_field.dart';
import 'package:animoo/view/signup/widgets/custom_Required_field.dart';
import 'package:animoo/view/signup/widgets/required_rules_for_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/enums/select_image_status.dart';
import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/widgets/custom_select_your_image_widget.dart';
import 'coustom_required_password_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.onPressedAtEyePassword,
    this.visiblePassword,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onPressedAtEyeConfirmPassword,
    this.visibleConfirmPassword,
    required this.onChanged,
    required this.fileImage,
    required this.onTapAtSelectImage, required this.selectImageStatus,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback onPressedAtEyePassword;
  final VoidCallback onPressedAtEyeConfirmPassword;
  final bool? visiblePassword;
  final bool? visibleConfirmPassword;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final ValueChanged<String> onChanged;
  final File? fileImage;
  final GestureTapCallback onTapAtSelectImage;
  final SelectImageStatus selectImageStatus;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRequiredField(
            validator: (value) {
              return AppVaildators.nameValidator(value);
            },
            fieldTitle: "First Name",
            controller: firstNameController,
          ),
          CustomRequiredField(
            validator: (value) {
              return AppVaildators.nameValidator(value);
            },
            fieldTitle: "Last Name",
            controller: lastNameController,
          ),

          CustomRequiredField(
            validator: (value) {
              return AppVaildators.emailValidator(value);
            },
            fieldTitle: "Email",
            controller: emailController,
          ),
          CoustomRequiredPasswordField(
            onChanged: onChanged,
            usedValidate: true,
            controller: passwordController,
            fieldTitle: "Password",
            onPressedAtEye: onPressedAtEyePassword,
            visible: visiblePassword,
          ),
          RequiredRulesForPassword(),
          CoustomRequiredConfirmPasswordField(
            password: passwordController.getText,
            controller: confirmPasswordController,
            fieldTitle: "Confirm Password",
            onPressedAtEye: onPressedAtEyeConfirmPassword,
            visible: visibleConfirmPassword,
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
          CustomSelectImageWidget(
            selectImageStatus: selectImageStatus,
            onTapAtSelectImage: onTapAtSelectImage,
            
           
            file: fileImage,
          ),
          SizedBox(height: 28.h),
        ],
      ),
    );
  }
}
