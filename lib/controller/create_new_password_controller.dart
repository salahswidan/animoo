import 'dart:async';

import 'package:animoo/core/di/services/internet_checker_service.dart';
import 'package:animoo/core/enums/button_states_enum.dart';
import 'package:animoo/core/enums/screen_status_state.dart';
import 'package:animoo/core/functions/app_scaffold_massanger.dart';
import 'package:animoo/core/resources/extenstions.dart';
import 'package:animoo/data/network/auth_api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/error/failure_model.dart';
import '../core/resources/conts_values.dart';
import '../core/resources/routes_manager.dart';
import '../model/auth/create_new_password_response.dart';

class CreateNewPasswordController {
  bool eyeVisibleNewPassword = false;
  bool eyeVisibleConfirmPassword = false;

  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  ScreenStatusState screenState = ScreenStatusState.initial;

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
  late String email;

  void getArguments() {
    ModalRoute<Object?>? modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      var arguments = modalRoute.settings.arguments;
      if (arguments != null && arguments is Map<String, dynamic>) {
        email = arguments[ConstsValuesManager.email];
      }
    }
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

  void onTapAtSubmitButton() async {
    if (checkPasswordAndConfirmPasswordMatch() == true) {
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?now make api request
        _requestChangePassword();
      } else {
        if (context.mounted) {
          showAppSnackBar(context, ConstsValuesManager.noInternetConnection);
        }
      }
    } else {
      if (context.mounted) {
        showAppSnackBar(
          context,
          ConstsValuesManager.passwordAndConfirmPasswordMustBeTheSame,
        );
      }
    }
  }

  void _requestChangePassword() async {
    screenState = ScreenStatusState.loading;
    changeScreenStateLoading();
    Either<FailureModel, CreateNewPasswordResponse> result =
        await AuthApi.createNewPassword(
          email,
          newPasswordController.getText,
          confirmPasswordController.getText,
        );
    print(result);
    result.fold(
      (FailureModel l) {
        _onFailureRequest(l, context);
      },

      (CreateNewPasswordResponse r) {
        print(r);
        _onSuccessRequest(r, context);
      },
    );
    changeScreenStateLoading();
  }

  void changeScreenStateLoading() {
    loadingScreenInput.add(screenState == ScreenStatusState.loading);
  }

  void _onSuccessRequest(CreateNewPasswordResponse r, BuildContext context) {
    screenState = ScreenStatusState.success;

    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.loginPage,
      (route) => false,
    );
  }

  void _onFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreenStatusState.failure;
    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: () {
        onTapAtSubmitButton();
      },
    );
  }

  String _filterErrors(List<String> errors) {
    List<String> errorList = [];
    errors = errors.map((e) => e.toLowerCase().trim()).toList();
    void makeFilter(String contain, String msgError) {
      if (errors.join("").contains(contain.toLowerCase())) {
        errorList.add(msgError);
      }
    }

    if (errors.isNotEmpty) {
      makeFilter("email is required", 'email is required');
      makeFilter("Not found this email", 'Not found this email');
      makeFilter("password is required", 'enter valid password');
      makeFilter("confirmPassword", 'enter valid confirm password');
      makeFilter("Invalid email", 'enter valid email');
      makeFilter(
        "Password and confirm password not match",
        'Password and confirm password not match',
      );
      makeFilter(
        "Password must be at least 6 characters and include letters and numbers",
        'Password must be at least 6 characters and include letters and numbers',
      );
    }

    return errorList.join(" , ");
  }
}
