import 'dart:async';

import 'package:animoo/core/enums/screen_status_state.dart';
import 'package:animoo/model/auth/otp_code_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/error/failure_model.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/resources/conts_values.dart';
import '../data/network/auth_api.dart';

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
    if (otpCode != null) {
      screenState = ScreenStatusState.loading;
      changeScreenStateLoading();
      //? request api
      var isInternetConnected = await InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?now make api request
        _requestCheckOtpCodeAvailability(context);
      } else {
        _showNoInternetSnackBar(context);
      }
      screenState = ScreenStatusState.success;
      changeScreenStateLoading();
      //?go to create new password after request on api
    } else {
      showAppSnackBar(context, "Please enter a valid OTP code");
    }
  }

  void _requestCheckOtpCodeAvailability(BuildContext context) async {
    changeScreenStateLoading();
    Either<FailureModel, OtpCodeResponse> response =
        await AuthApi.checkOtpAvailability(email, otpCode!);

    response.fold(
      (FailureModel l) {
        print(l);
        OnFailureRequest(l, context);
      },

      (OtpCodeResponse r) {
        print(r);
        OnSuccessResquest(r, context);
      },
    );
    changeScreenStateLoading();
  }

  void OnFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreenStatusState.failure;
  }

  void OnSuccessResquest(OtpCodeResponse r, BuildContext context) {
    screenState = ScreenStatusState.success;
  }
}
