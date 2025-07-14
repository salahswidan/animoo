import 'dart:async';
import 'dart:io';

import 'package:animoo/core/enums/button_states_enum.dart';
import 'package:animoo/core/enums/screen_status_state.dart';
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
import '../model/auth/password_rules_model.dart';

class SignUpController {
  File? fileImage;
  SelectImageStatus selectImageStatus = SelectImageStatus.normal;
  ButtonStatesEnum signUpButtonStatus = ButtonStatesEnum.disabled;
  ScreenStatusState screenState = ScreenStatusState.initial;
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;

  bool visibleConfirmPassword = true;
  bool visiblePassword = true;

  late Stream<File?> fileImageOutputStream;
  late Sink<File?> fileImageInput;
  late StreamController<File?> fileImageController;

  late Stream<bool> visiblePasswordOutputStream;
  late Sink<bool> visiblePasswordInput;
  late StreamController<bool> visiblePasswordController;

  late Stream<bool> visibleConfirmPasswordOutputStream;
  late Sink<bool> visibleConfirmPasswordInput;
  late StreamController<bool> visibleConfirmPasswordController;

  late Stream<ButtonStatesEnum?> signUpButtonStatusOutputStream;
  late Sink<ButtonStatesEnum?> signUpButtonStatusInput;
  late StreamController<ButtonStatesEnum?> signUpButtonStatusController;

  late Stream<List<PasswordRulesModel>> listPasswordRulesOutputStream;
  late Sink<List<PasswordRulesModel>> listPasswordRulesInput;
  late StreamController<List<PasswordRulesModel>> listPasswordRulesController;

  late Stream<bool> loadingScreenStatusOutputStream;
  late StreamController<bool> loadingScreenStatusController;
  late Sink<bool> loadingScreenStatusInput;

  @override
  void initState() {
    //?init controllers
    initControllers();
    //?init streams
    initStreams();
    //?init rules
    changePasswordRules();
  }

  void dispose() {
    disposeControllers();
    disposeStreams();
  }

  void initControllers() async {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();

    firstNameController.text = 'salah';
    lastNameController.text = 'ahmed';
    emailController.text = 'salahswidan@gmail.com';
    passwordController.text = '123456qwerty!Q';
    confirmPasswordController.text = '123456qwerty!Q';
    phoneController.text = '01553798716';
  }

  void initStreams() {
    fileImageController = StreamController<File?>();
    fileImageInput = fileImageController.sink;
    fileImageOutputStream = fileImageController.stream;
    visiblePasswordController = StreamController<bool>();
    visiblePasswordInput = visiblePasswordController.sink;
    visiblePasswordOutputStream = visiblePasswordController.stream;
    visibleConfirmPasswordController = StreamController<bool>();
    visibleConfirmPasswordInput = visibleConfirmPasswordController.sink;
    visibleConfirmPasswordOutputStream =
        visibleConfirmPasswordController.stream;
    signUpButtonStatusController = StreamController<ButtonStatesEnum?>();
    signUpButtonStatusInput = signUpButtonStatusController.sink;
    signUpButtonStatusOutputStream = signUpButtonStatusController.stream;
    listPasswordRulesController = StreamController<List<PasswordRulesModel>>();
    listPasswordRulesInput = listPasswordRulesController.sink;
    listPasswordRulesOutputStream = listPasswordRulesController.stream;
    loadingScreenStatusController = StreamController<bool>();
    loadingScreenStatusInput = loadingScreenStatusController.sink;
    loadingScreenStatusOutputStream = loadingScreenStatusController.stream;
  }

  void disposeStreams() {
    fileImageController.close();
    fileImageInput.close();
    visiblePasswordController.close();
    visiblePasswordInput.close();
    visibleConfirmPasswordController.close();
    visibleConfirmPasswordInput.close();
    signUpButtonStatusController.close();
    signUpButtonStatusInput.close();
    listPasswordRulesController.close();
    listPasswordRulesInput.close();
    loadingScreenStatusController.close();
    loadingScreenStatusInput.close();
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
    ConstsListsManager.passwordRulesRequirements[index].valid = value;
    changePasswordRules();
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
      () {
        _onTapAtCamera(context);
      },

      () {
        _onTapAtGallery(context);
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

  Future<void> onTapSignUp(BuildContext context) async {
    //?check if image is selected
    if (selectImageStatus == SelectImageStatus.normal) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    }
    if (formKey.currentState!.validate() &&
        selectImageStatus == SelectImageStatus.imageSelected) {
      screenState = ScreenStatusState.loading;
      changeLoadingScreenStatus();
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
          screenState = ScreenStatusState.failure;
          String massage = filterErrors(l.error);
          showMySnackBar(context, massage);
          print(l.error);
        },
        (AuthResponse r) {
          screenState = ScreenStatusState.success;
          print(r);
        },
      );
      changeLoadingScreenStatus();
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
    changeSignUpButtonStatus();
  }

  void changeSignUpButtonStatus() {
    signUpButtonStatusInput.add(signUpButtonStatus);
  }

  void onPressedAtEyePassword() {
    visiblePassword = !visiblePassword;
    visiblePasswordInput.add(visiblePassword);
  }

  void onPressedAtEyeConfirmPassword() {
    visibleConfirmPassword = !visibleConfirmPassword;
    visibleConfirmPasswordInput.add(visibleConfirmPassword);
  }

  void _onTapAtCamera(context) async {
    fileImage = await ImagePickerService.pickImage(ImageSource.camera);
    fileImageInput.add(fileImage);
    Navigator.pop(context);
  }

  void _onTapAtGallery(BuildContext context) async {
    fileImage = await ImagePickerService.pickImage(ImageSource.gallery);
    fileImageInput.add(fileImage);
    Navigator.pop(context);
  }

  void changePasswordRules() {
    listPasswordRulesInput.add(ConstsListsManager.passwordRulesRequirements);
  }

  void changeLoadingScreenStatus() {
    loadingScreenStatusInput.add(screenState == ScreenStatusState.loading);
  }

  void showMySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String filterErrors(List<String> error) {
    String description = '';
    if (error.isNotEmpty) {
      for (var error in error) {
        if (error.toLowerCase().trim().contains("email already")) {
          description += 'email already exists';
        }
        if (error.toLowerCase().trim().contains("invalid email")) {
          description += 'enter valid email';
        }
        if (error.toLowerCase().trim().contains("phone")) {
          description += 'phone is required';
        }
        if (error.toLowerCase().trim().contains("password")) {
          description += 'password is required';
        }
        if (error.toLowerCase().trim().contains("first name")) {
          description += 'first name is required';
        }
        if (error.toLowerCase().trim().contains("last name")) {
          description += 'last name is required';
        }
        if (error.toLowerCase().trim().contains("image")) {
          description += 'image is required';
        }
      }
    }
    return description;
  }
}
