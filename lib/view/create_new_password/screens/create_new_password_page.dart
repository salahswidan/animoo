import 'package:animoo/core/widgets/app_bar/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/widgets/bottons/app_button.dart';
import '../../signup/widgets/custom_Required_field.dart';
import '../../signup/widgets/required_rules_for_password.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Cancel"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 9.h),

                Text(
                  "Create New Password",
                  style: TextStyle(
                    fontFamily: fontsManager.Otama,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                SizedBox(height: 10.h),
                CreateNewPasswordForm(
                  onPressedAtEye: () {},
                  formKey: GlobalKey<FormState>(),
                  visible: true,
                ),
                SizedBox(height: 82.h),
                App_Button(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(RoutesName.otpVerficationCodePage);
                  },
                  text: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateNewPasswordForm extends StatelessWidget {
  const CreateNewPasswordForm({
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
    return Column(
      children: [
        CustomRequiredField(
          controller: TextEditingController(),
          fieldTitle: "New Password",
          onPressedAtEye: onPressedAtEye,
          visible: visible,
        ),
        RequiredRulesForPassword(),
        CustomRequiredField(
          controller: TextEditingController(),
          fieldTitle: "Confirm Password",
          onPressedAtEye: onPressedAtEye,
          visible: visible,
        ),
      ],
    );
  }
}
