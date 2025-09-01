import 'dart:async';

import 'package:animoo/core/enums/screen_status_state.dart';
import 'package:animoo/core/resources/routes_manager.dart';
import 'package:animoo/model/auth/otp_code_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/error/failure_model.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/resources/conts_values.dart';
import '../data/network/auth_api.dart';
import '../model/auth/new_otp_code_response.dart';

class OtpVerController {
  late String screenName;
  late String email;
  late Timer _timer;
  int counter = 60;
  String? otpCode;
  bool isCodeSend = false;


  ScreenStatusState screenState = ScreenStatusState.initial;

  late Stream<bool> loadingScreenStateOutputStream;
  late StreamController<bool> loadingScreenStateController;
  late StreamSink<bool> loadingScreenStateInput;

  late Stream<int> counterOutPutStream;
  late StreamController<int> counterController;
  late StreamSink<int> counterInput;

  final BuildContext context;


  OtpVerController(this.context) {
    initStreams();
    //? init screen state
    changeScreenStateLoading();
    //? start timer
    startTimer();
  }

  void startTimer() {
    counter = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 0) {
        counter--;
      } else {
        timer.cancel();
      }
      if (!counterController.isClosed) counterInput.add(counter);
    });
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
    if ((screenName == ConstsValuesManager.login ||
        screenName == RoutesName.forgetPasswordPage )
        && isCodeSend == false ) {
      _requestNewOtpCode(context);
      isCodeSend = true;
    }
  }

  void startOtpVerification(String value) {
    otpCode = value;
  }

  void initStreams() {
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateInput = loadingScreenStateController.sink;
    loadingScreenStateOutputStream = loadingScreenStateController.stream;

    counterController = StreamController<int>();
    counterInput = counterController.sink;
    counterOutPutStream = counterController.stream;
  }

  void disposeStreams() {
    loadingScreenStateController.close();
    loadingScreenStateInput.close();

    counterController.close();
    counterInput.close();
  }

  void dispose() {
    disposeStreams();
    _timer.cancel();
  }

  void changeScreenStateLoading() {
    if (!loadingScreenStateController.isClosed)
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
        if (context.mounted) {
          _requestCheckOtpCodeAvailability(context);
        }
      } else {
        if (context.mounted) {
          _showNoInternetSnackBar(context);
        }
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
        _onFailureRequest(l, context);
      },

      (OtpCodeResponse r) {
        otpOnSuccessResquest(r, context);
      },
    );
    changeScreenStateLoading();
  }

  void _onFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreenStatusState.failure;
    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: () {
        onPressedConfirmButton();
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
      makeFilter("invalid verfication code", 'enter valid verification code');
      makeFilter("database error", 'Database error');
    }

    return errorList.join(" , ");
  }

  void otpOnSuccessResquest(OtpCodeResponse r, BuildContext context) {
    screenState = ScreenStatusState.success;
    if(screenName == RoutesName.forgetPasswordPage) {
      //? go to create new password page
      Navigator.pushNamed(
        context,
        RoutesName.createNewPassword,
        arguments: {
          ConstsValuesManager.email: email,
        }, 
      );
    } else {
      //? go to sign in page
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.loginPage,
        (route) => false,
    );
    }
  } 

  void onPressedResendCodeButton() async {
    screenState = ScreenStatusState.loading;
    changeScreenStateLoading();
    //? request api
    var isInternetConnected = await InternetCheckerService();
    bool result = await isInternetConnected();
    if (result == true) {
      //?now make api request
      if (context.mounted) {
        _requestNewOtpCode(context);
      }
    } else {
      if (context.mounted) {
        _showNoInternetSnackBar(context);
      }
      screenState = ScreenStatusState.failure;
      changeScreenStateLoading();
    }
    //?go to create new password after request on api
  }

  void _requestNewOtpCode(BuildContext context) async {
    Either<FailureModel, NewOtpCodeResponse> response =
        await AuthApi.resendOtpCode(email);

    response.fold(
      (FailureModel l) {
        _onFailureRequest(l, context);
      },

      (NewOtpCodeResponse r) {
        if (context.mounted) {
          showAppSnackBar(context, "resend OTP code successfully");
        }
        screenState = ScreenStatusState.success;
        startTimer();
      },
    );
    changeScreenStateLoading();
  }
}
