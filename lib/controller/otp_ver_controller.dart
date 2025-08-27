import 'dart:async';

import 'package:animoo/core/enums/screen_status_state.dart';
import 'package:flutter/material.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/resources/conts_values.dart';

class OtpVerController {
  late String screenName;
  late String email;
  String? otpCode;

  ScreenStatusState screenState = ScreenStatusState.initial;

  late Stream<bool> loadingScreenStateOutputStream;
  late StreamController<bool> loadingScreenStateController;
  late StreamSink<bool> loadingScreenStateInput;

  final BuildContext context;

  OtpVerController(this.context) {
    initStreams();
    //? init screen state
    changeScreenStateLoading();
  }

  void getArguments(BuildContext context) {
    ModalRoute<Object?>? modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      var arguments = modalRoute.settings.arguments;
      if (arguments != null && arguments is Map<String, dynamic>) {
        screenName = arguments[ConstsValuesManager.screenName];
        email = arguments[ConstsValuesManager.email];
      }
    }
  }

  void startOtpVerification(String value) {
    otpCode = value;
  }

  void initStreams() {
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateInput = loadingScreenStateController.sink;
    loadingScreenStateOutputStream = loadingScreenStateController.stream;
  }

  void dispose() {
    loadingScreenStateController.close();
    loadingScreenStateInput.close();
  }

  void changeScreenStateLoading() {
    loadingScreenStateInput.add(screenState == ScreenStatusState.loading);
  }

  void _showNoInternetSnackBar(BuildContext context) {
    screenState = ScreenStatusState.failure;
    changeScreenStateLoading();
    showAppSnackBar(
      context,
      "No internet connection",
      onPressedAtRetry: () {
        onPressedConfirmButton();
      },
    );
  }

  void onPressedConfirmButton() async {
    screenState = ScreenStatusState.loading;
    changeScreenStateLoading();
    //? request api
    var isInternetConnected = await InternetCheckerService();
    bool result = await isInternetConnected();
    if (result == true) {
      //?now make api request
      // _requestCheckOtpCodeAvailability(context);
    } else {
      _showNoInternetSnackBar(context);
    }
    screenState = ScreenStatusState.success;
    changeScreenStateLoading();
    //?go to create new password after request on api
  }
}
