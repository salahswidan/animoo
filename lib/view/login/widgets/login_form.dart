import 'package:animoo/core/functions/app_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/conts_values.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/widgets/custom_required_field.dart';
import '../../../core/widgets/custom_required_password_field.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.onPressedAtEye,
    required this.eyeVisibleOutPutStream,
    required this.emailController,
    required this.passwordController, this.onChanged,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback? onPressedAtEye;
  final Stream<bool> eyeVisibleOutPutStream;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomRequiredField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return AppValidators.emailValidator(value);
            },
            onChanged: onChanged,
            controller: emailController,
            title: ConstsValuesManager.email,
            hintText: ConstsValuesManager.enterYourEmailAddress,
          ),
          VerticalSpace(HeightsManager.h16),

          StreamBuilder<bool>(
            stream: eyeVisibleOutPutStream,
            initialData: false,
            builder: (context, snapshot) {
              return CustomRequiredPasswordField(
                usedValidate: true,
                useDefaultErrorBuilder: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  } else {
                    return null;
                  }
                },
                onChanged: onChanged,
                title: ConstsValuesManager.password,
                onPressedAtEye: onPressedAtEye,
                visible: snapshot.data ?? false,
                controller: passwordController,
                hintText: ConstsValuesManager.enterYourPassword,
              );
            },
          ),
        ],
      ),
    );
  }
}
