import 'package:flutter/material.dart';

import '../../../../core/resources/conts_values.dart';
import '../../../../core/resources/heights_manager.dart';
import '../../../../core/widgets/custom_required_password_field.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';
import '../../../../model/auth/password_rules_model.dart';
import '../../../signup/widgets/required_rules_for_password_sign_up_page.dart';

class CreateNewPasswordForm extends StatelessWidget {
  const CreateNewPasswordForm({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onPressedAtEyeNewPassword,
    required this.onPressedAtEyeConfirmPassword,
    required this.visibleNewPasswordOutputStream,
    required this.visibleConfirmPasswordOutputStream,
    required this.formKey,
    required this.onChanged,
  });
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onPressedAtEyeNewPassword;
  final VoidCallback onPressedAtEyeConfirmPassword;

  final Stream<bool> visibleNewPasswordOutputStream;
  final Stream<bool> visibleConfirmPasswordOutputStream;
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          StreamBuilder<bool>(
            initialData: false,
            stream: visibleNewPasswordOutputStream,
            builder:
                (context, snapshot) => CustomRequiredPasswordField(
                  controller: newPasswordController,
                  onPressedAtEye: onPressedAtEyeNewPassword,
                  title: ConstsValuesManager.newPassword,
                  hintText: ConstsValuesManager.enterYourPassword,
                  visible: snapshot.data ?? false,
                  onChanged: onChanged,
                  useDefaultErrorBuilder: true,
                  usedValidate: true,
                ),
          ),

          VerticalSpace(HeightsManager.h8),

          RequiredRulesForPasswordSignUpPage(
            listPasswordRulesOutputStream:
                Stream<List<PasswordRulesModel>>.empty(),
          ),
          StreamBuilder(
            initialData: false,
            stream: visibleConfirmPasswordOutputStream,
            builder:
                (context, snapshot) => CustomRequiredPasswordField(
                  onPressedAtEye: onPressedAtEyeConfirmPassword,
                  title: ConstsValuesManager.confirmPassword,
                  visible: snapshot.data ?? false,
                  controller: confirmPasswordController,
                  hintText: ConstsValuesManager.enterYourConfirmPassword,
                  onChanged: onChanged,
                  useDefaultErrorBuilder: true,
                  usedValidate: true,
                ),
          ),
          VerticalSpace(HeightsManager.h82),
        ],
      ),
    );
  }
}
