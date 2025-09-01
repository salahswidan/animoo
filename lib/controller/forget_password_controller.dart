import 'dart:async';

import 'package:flutter/material.dart';

import '../core/enums/button_states_enum.dart';
import '../core/resources/conts_values.dart';
import '../core/resources/routes_manager.dart';

class ForgetPasswordController {
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  ButtonStatesEnum forgetPasswordButtonStatus = ButtonStatesEnum.disabled;
  late TextEditingController emailController;

  late Stream<ButtonStatesEnum> sendCodeButtonStatusOutputStream;
  late Sink<ButtonStatesEnum> sendCodeButtonStatusInput;
  late StreamController<ButtonStatesEnum> sendCodeButtonStatusController;

  ForgetPasswordController() {
    init();
  }

  void init() {
    //? init controllers
    initControllers();
    //? init text controllers
    initTextControllers();
    //? change button status
    changeSendCodeButtonStatus(ButtonStatesEnum.disabled);
  }

  void initTextControllers() {
    emailController = TextEditingController();
  }

  void initControllers() {
    sendCodeButtonStatusController = StreamController<ButtonStatesEnum>();
    sendCodeButtonStatusInput = sendCodeButtonStatusController.sink;
    sendCodeButtonStatusOutputStream = sendCodeButtonStatusController.stream;
  }

  void changeSendCodeButtonStatus(ButtonStatesEnum status) {
    sendCodeButtonStatusInput.add(status);
  }

  void dispose() {
    disposeStreams();
  }

  void disposeStreams() {
    sendCodeButtonStatusController.close();
    sendCodeButtonStatusInput.close();
  }

  void onChangeTextField(String value) {
    if (forgetPasswordFormKey.currentState!.validate()) {
      changeSendCodeButtonStatus(ButtonStatesEnum.enabled);
    } else {
      changeSendCodeButtonStatus(ButtonStatesEnum.disabled);
    }
  }

  void onTapAtSendCodeButton(BuildContext context) {
    Navigator.of(context).pushNamed(
      RoutesName.otpVerificationScreen,
      arguments: {
        ConstsValuesManager.email: emailController.text,
        ConstsValuesManager.screenName: RoutesName.forgetPasswordPage,
      },
    );
  }
}
