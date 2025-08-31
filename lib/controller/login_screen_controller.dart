import 'dart:async';

import 'package:animoo/core/di/services/internet_checker_service.dart';
import 'package:animoo/core/functions/app_scaffold_massanger.dart';
import 'package:animoo/core/resources/extenstions.dart';
import 'package:animoo/data/network/auth_api.dart';
import 'package:animoo/model/auth/auth_response.dart';
import 'package:animoo/model/auth/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/enums/button_states_enum.dart';
import '../core/enums/screen_status_state.dart';
import '../core/error/failure_model.dart';
import '../core/resources/conts_values.dart';
import '../core/resources/routes_manager.dart';

class LoginScreenController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  ButtonStatesEnum loginButtonStatus = ButtonStatesEnum.disabled;
  ScreenStatusState screenState = ScreenStatusState.initial;
  bool eyeVisible = false;
  //? text controllers
  late TextEditingController emailController;
  late TextEditingController passwordController;
  //? streams
  late StreamController<bool> eyeStreamController;
  late Stream<bool> eyeVisibleOutPutStream;
  late Sink<bool> eyeInput;

  late Stream<ButtonStatesEnum> loginButtonStatusOutputStream;
  late Sink<ButtonStatesEnum> loginButtonStatusInput;
  late StreamController<ButtonStatesEnum> loginButtonStatusController;

  late Stream<bool> loadingScreenStateOutputStream;
  late Sink<bool> loadingScreenStateInput;
  late StreamController<bool> loadingScreenStateController;

  final BuildContext context;

  LoginScreenController(this.context) {
    init();
  }

  void init() {
    //? init controllers
    initControllers();
    //? init text controllers
    initTextControllers();
    //? change button status
    changeButtonStatus(ButtonStatesEnum.disabled);
  }

  void changeButtonStatus(ButtonStatesEnum status) {
    loginButtonStatusInput.add(status);
  }

  void initControllers() {
    eyeStreamController = StreamController<bool>();
    eyeVisibleOutPutStream = eyeStreamController.stream;
    eyeInput = eyeStreamController.sink;

    loginButtonStatusController = StreamController<ButtonStatesEnum>();
    loginButtonStatusInput = loginButtonStatusController.sink;
    loginButtonStatusOutputStream =
        loginButtonStatusController.stream.asBroadcastStream();

    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateInput = loadingScreenStateController.sink;
    loadingScreenStateOutputStream =
        loadingScreenStateController.stream.asBroadcastStream();
  }

  void initTextControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void dispose() {
    disposeStreams();
  }

  void disposeStreams() {
    eyeStreamController.close();
    eyeInput.close();
  }

  void onPressedAtEye() {
    eyeVisible = !eyeVisible;
    eyeInput.add(eyeVisible);
  }

  void onPressedAtForgetPassword() {
    Navigator.of(context).pushNamed(RoutesName.forgetPassword);
  }

  void onPressedAtLoginButton() async {
    if (loginFormKey.currentState!.validate()) {
      //? request login
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //? make api call
        _requestLogin();
      } else {
        showAppSnackBar(
          context,
          'No internet connection',
          onPressedAtRetry: () {
            onPressedAtLoginButton();
          },
        );
      }
    }
  }

  void onChangeTextField(String value) {
    if (loginFormKey.currentState!.validate()) {
      changeButtonStatus(ButtonStatesEnum.enabled);
    } else {
      changeButtonStatus(ButtonStatesEnum.disabled);
    }
  }

  void _requestLogin() async {
    screenState = ScreenStatusState.loading;
    changeLoadingScreenState();
    //? make api call
    Either<FailureModel, LoginResponse> response = await AuthApi.login(
      emailController.getText,
      passwordController.getText,
    );

    response.fold(
      (FailureModel l) {
        _OnFailureRequest(l, context);
      },
      (LoginResponse r) {
        _OnSuccessResquest(r, context);
      },
    );
  }

  void changeLoadingScreenState() {
    loadingScreenStateInput.add(screenState == ScreenStatusState.loading);
  }
    void _OnSuccessResquest(LoginResponse r, BuildContext context) {
    screenState = ScreenStatusState.success;
    showAppSnackBar(context, r.message ?? "");
    // Navigator.pushNamed(
    //   context,
    //   RoutesName.otpVerificationScreen,
    //   arguments: {
    //     ConstsValuesManager.email: emailController.getText,
    //     ConstsValuesManager.screenName: ConstsValuesManager.signUp,
    //   },
    // );

  }
    void _OnFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreenStatusState.failure;
    String massage = _filterErrors(l.errors);
    showAppSnackBar(context, massage,onPressedAtRetry: () {
      onPressedAtLoginButton();
    });
    print(l.errors);
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
      makeFilter("password is required", 'password is required');
      makeFilter("password or email not true", 'password or email not true');
      makeFilter("Account not verified", 'Account not verified');
     
    }

    return errorList.join(" , ");
  }

}
