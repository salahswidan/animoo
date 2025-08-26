
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/app_bar/simple_app_bar.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/custom_required_password_field.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../../../model/auth/password_rules_model.dart';
import '../../signup/widgets/required_rules_for_password_sign_up_page.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: ConstsValuesManager.cancel),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PaddingManager.pw18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(HeightsManager.h9_15),
                Text(
                  ConstsValuesManager.createNewPassword,
                  style: TextStyle(
                    fontFamily: FontsManager.otamaEpFontFamily,
                    fontSize: FontSizeManager.s20,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                VerticalSpace(HeightsManager.h10),
                CreateNewPasswordForm(),
                AppButton(text: ConstsValuesManager.submit, onTap: () {

                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateNewPasswordForm extends StatelessWidget {
  const CreateNewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRequiredPasswordField(
          controller: TextEditingController(),
          onPressedAtEye: () {},
          title: ConstsValuesManager.newPassword,
          hintText: ConstsValuesManager.enterYourPassword,
          visible: true,
        ),

        VerticalSpace(HeightsManager.h8),

        RequiredRulesForPasswordSignUpPage(
          listPasswordRulesOutputStream: Stream<List<PasswordRulesModel>>.empty(),
          
        ),
        CustomRequiredPasswordField(
          onPressedAtEye: () {},
          title: ConstsValuesManager.confirmPassword,
          visible: true,
          controller: TextEditingController(),
          hintText: ConstsValuesManager.enterYourConfirmPassword,
        ),
        VerticalSpace(HeightsManager.h82),
      ],
    );
  }
}
