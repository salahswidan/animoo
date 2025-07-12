import 'dart:io';

import 'package:animoo/core/enums/button_states_enum.dart';
import 'package:animoo/core/enums/select_image_status.dart';
import 'package:animoo/core/resources/extenstions.dart';
import 'package:animoo/data/network/auth_api.dart';
import 'package:animoo/model/auth/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/error/failure_model.dart';
import '../core/functions/image_picker_service.dart';
import '../core/functions/show_select_image_model_bottom_sheet.dart';
import '../core/resources/conts_values.dart';
import '../model/auth/auth_response.dart';

class SignUpController {
  SelectImageStatus selectImageStatus = SelectImageStatus.normal;
  ButtonStatesEnum signUpButtonStatus = ButtonStatesEnum.disabled;
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;

  bool visibleConfirmPassword = true;
  bool visiblePassword = true;

  File? fileImage;

  void initState() {
    //?init controllers
    initControllers();
    //?
  }

  void dispose() {
    disposeControllers();
  }

  void initControllers() async {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
  }

  SignUpController() {
    initState();
  }

  void _changeRule(int index, bool value) {
    ConstsListsManager.passwordRulesRequirements[index][ConstsValuesManager
            .valid] =
        value;
  }

  void onChangePassword(String value) {
    passwordController.text = passwordController.getText;
    //?check value is less than 12
    if (value.trim().length < 12) {
      _changeRule(0, false);
    } else {
      _changeRule(0, true);
    }
    //?check value contains at least one uppercase letter
    if (!value.trim().contains(RegExp(r"[A-Z]"))) {
      _changeRule(1, false);
    } else {
      _changeRule(1, true);
    }
    //?check value contains at least one lowercase letter
    if (!value.trim().contains(RegExp(r"[a-z]"))) {
      _changeRule(2, false);
    } else {
      _changeRule(2, true);
    }
    //?check value contains at least one special character
    if (!value.trim().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _changeRule(3, false);
    } else {
      _changeRule(3, true);
    }
    //?check value contains at least one number
    if (!value.trim().contains(RegExp(r"[0-9]"))) {
      _changeRule(4, false);
    } else {
      _changeRule(4, true);
    }
  }

  Future<void> onTapAtSelectImage(BuildContext context) async {
    //?chow model bottom sheet
    await showSelectImageModelBottomSheet(
      context,
      () async {
        fileImage = await ImagePickerService.pickImage(ImageSource.camera);
        Navigator.pop(context);
      },
      () async {
        fileImage = await ImagePickerService.pickImage(ImageSource.gallery);
        Navigator.pop(context);
      },
    );

    //?check if image is selected
    if (fileImage == null) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    } else {
      selectImageStatus = SelectImageStatus.imageSelected;
      checkValidate();
    }
  }

  Future<void> onTapSignUp() async {
    //?check if image is selected
    if (selectImageStatus == SelectImageStatus.normal) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    }
    if (formKey.currentState!.validate() &&
        selectImageStatus == SelectImageStatus.imageSelected) {
      //? make api

      Either<FailureModel, AuthResponse> response = await AuthApi.signUp(
        UserModel(
          firstName: firstNameController.getText,
          lastName: lastNameController.getText,
          email: emailController.getText,
          password: passwordController.text,
          phone: phoneController.getText,
          image: fileImage!,
        ),
      );
      response.fold(
        (FailureModel l) {
          print(l.error);
        },
        (AuthResponse r) {
          print(r);
        },
      );
    }
  }

  void checkValidate() {
    //?check if image is selected
    if (selectImageStatus == SelectImageStatus.normal) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    }
    if (formKey.currentState!.validate() &&
        selectImageStatus == SelectImageStatus.imageSelected) {
      //? make api
      signUpButtonStatus = ButtonStatesEnum.enabled;
    } else {
      signUpButtonStatus = ButtonStatesEnum.disabled;
    }
  }

  void onPressedAtEyePassword() {
    visiblePassword = !visiblePassword;
  }

  void onPressedAtEyeConfirmPassword() {
    visibleConfirmPassword = !visibleConfirmPassword;
    print(visibleConfirmPassword);
  }
}
