import 'dart:async';

import 'package:animoo/core/enums/button_states_enum.dart';
import 'package:animoo/core/functions/app_scaffold_massanger.dart';
import 'package:flutter/material.dart';

import '../core/resources/conts_values.dart';

class CreateNewPasswordController {
  bool eyeVisibleNewPassword = false;
  bool eyeVisibleConfirmPassword = false;

  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late StreamController<bool> visibleNewPasswordStreamController;
  late Stream<bool> visibleNewPasswordOutputStream;
  late Sink<bool> visibleNewPasswordInput;

  late StreamController<bool> visibleConfirmPasswordStreamController;
  late Stream<bool> visibleConfirmPasswordOutputStream;
  late Sink<bool> visibleConfirmPasswordInput;

  late StreamController<ButtonStatesEnum> submitButtonStreamController;
  late Stream<ButtonStatesEnum> submitButtonOutputStream;
  late Sink<ButtonStatesEnum> submitButtonInput;

  late StreamController<bool> loadingScreenStream;
  late Stream<bool> loadingScreenOutputStream;
  late Sink<bool> loadingScreenInput;

  final BuildContext context;

  CreateNewPasswordController(this.context) {
    init();
  }

  void init() {
    initTextControllers();
    initStreams();
    changeSubmitButtonStatus(ButtonStatesEnum.disabled);
  }

  void initTextControllers() {
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void initStreams() {
    visibleNewPasswordStreamController = StreamController<bool>();
    visibleNewPasswordOutputStream = visibleNewPasswordStreamController.stream;
    visibleNewPasswordInput = visibleNewPasswordStreamController.sink;

    visibleConfirmPasswordStreamController = StreamController<bool>();
    visibleConfirmPasswordOutputStream =
        visibleConfirmPasswordStreamController.stream;
    visibleConfirmPasswordInput = visibleConfirmPasswordStreamController.sink;

    submitButtonStreamController = StreamController<ButtonStatesEnum>();
    submitButtonOutputStream = submitButtonStreamController.stream;
    submitButtonInput = submitButtonStreamController.sink;

    loadingScreenStream = StreamController<bool>();
    loadingScreenOutputStream = loadingScreenStream.stream;
    loadingScreenInput = loadingScreenStream.sink;
  }

  dispose() {
    disposeStreams();
    disposeTextControllers();
  }

  void disposeStreams() {
    visibleNewPasswordStreamController.close();
    visibleNewPasswordInput.close();
    visibleConfirmPasswordInput.close();
    visibleConfirmPasswordStreamController.close();
    submitButtonStreamController.close();
    submitButtonInput.close();
    loadingScreenStream.close();
    loadingScreenInput.close();
  }

  void disposeTextControllers() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void onPressedAtEyeNewPassword() {
    eyeVisibleNewPassword = !eyeVisibleNewPassword;
    visibleNewPasswordInput.add(eyeVisibleNewPassword);
  }

  void onPressedAtEyeConfirmPassword() {
    eyeVisibleConfirmPassword = !eyeVisibleConfirmPassword;
    visibleConfirmPasswordInput.add(eyeVisibleConfirmPassword);
  }

  void changeSubmitButtonStatus(ButtonStatesEnum status) {
    submitButtonInput.add(status);
  }

  void onChangeTextField(String value) {
    if (formKey.currentState!.validate()) {
      changeSubmitButtonStatus(ButtonStatesEnum.enabled);
    } else {
      changeSubmitButtonStatus(ButtonStatesEnum.disabled);
    }
  }

  bool checkPasswordAndConfirmPasswordMatch() {
    return newPasswordController.text == confirmPasswordController.text;
  }

  void onTapAtSubmitButton() {
    if (checkPasswordAndConfirmPasswordMatch() == true) {
    } else {
      if (context.mounted)
        showAppSnackBar(
          context,
          ConstsValuesManager.passwordAndConfirmPasswordMustBeTheSame,
        );
    }
  }
}
