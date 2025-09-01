import 'package:animoo/core/widgets/loading/app_madel_progress_hud.dart';
import 'package:flutter/material.dart';
import '../../../controller/create_new_password_controller.dart';
import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/app_bar/simple_app_bar.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import 'widget/create_new_password_form.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  late CreateNewPasswordController _createNewPasswordController;

  @override
  void initState() {
    super.initState();
    _createNewPasswordController = CreateNewPasswordController(context);
  }

  @override
  void dispose() {
    _createNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: ConstsValuesManager.cancel),
      body: AppModelProgressHud(
        loadingOutputStream: _createNewPasswordController.loadingScreenOutputStream,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw18),
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
                  CreateNewPasswordForm(
                    onChanged: _createNewPasswordController.onChangeTextField,
                    formKey: _createNewPasswordController.formKey,
                    newPasswordController:
                        _createNewPasswordController.newPasswordController,
                    confirmPasswordController:
                        _createNewPasswordController.confirmPasswordController,
                    onPressedAtEyeNewPassword:
                        _createNewPasswordController.onPressedAtEyeNewPassword,
                    onPressedAtEyeConfirmPassword:
                        _createNewPasswordController
                            .onPressedAtEyeConfirmPassword,
                    visibleNewPasswordOutputStream:
                        _createNewPasswordController
                            .visibleNewPasswordOutputStream,
                    visibleConfirmPasswordOutputStream:
                        _createNewPasswordController
                            .visibleConfirmPasswordOutputStream,
                  ),
                  AppButton(text: ConstsValuesManager.submit, onTap: _createNewPasswordController.onTapAtSubmitButton,
                  buttonStatusOutputStream: _createNewPasswordController.submitButtonOutputStream,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
