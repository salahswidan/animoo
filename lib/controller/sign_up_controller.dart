import 'dart:async';
import 'dart:io';
import 'package:animoo/core/di/services/internet_checker_service.dart';
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
import '../core/functions/app_navigations.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/functions/image_picker_service.dart';
import '../core/functions/show_select_image_model_bottom_sheet.dart';
import '../core/resources/conts_values.dart';
import '../core/resources/routes_manager.dart';
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
    lastNameController.text = 'swidan';
    emailController.text = 'salahswidan212@gmail.com';
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

  Future<void> onTapAtSelectImage(
    BuildContext context,
    FormFieldState<File> state,
  ) async {
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
      state.didChange(fileImage);
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
      var isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?now make api request
       if(context.mounted) _requestMakeNewUser(context);
      } else {
       if(context.mounted) _showNoInternetSnackBar(context);
      }
    }
  }

  void _showNoInternetSnackBar(BuildContext context) {
    screenState = ScreenStatusState.failure;
    changeLoadingScreenStatus();
    showAppSnackBar(context, "No internet connection",  onPressedAtRetry: () {
      onTapSignUp(context);
    },
      
    );
  }

  void _OnSuccessResquest(AuthResponse r, BuildContext context) {
    screenState = ScreenStatusState.success;
    showAppSnackBar(context, r.message ?? "");
    AppNavigation.pushNamed(
      context,
      RoutesName.otpVerificationScreen,
      arguments: {
        ConstsValuesManager.email: emailController.getText,
        ConstsValuesManager.screenName: ConstsValuesManager.signUp,
      },
    );
  }

  void _OnFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreenStatusState.failure;
    String massage = _filterErrors(l.errors);
    showAppSnackBar(context, massage,onPressedAtRetry: () {
      onTapSignUp(context);
    });
    print(l.errors);
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
   if(context.mounted) Navigator.pop(context);
  }

  void changePasswordRules() {
    listPasswordRulesInput.add(ConstsListsManager.passwordRulesRequirements);
  }

  void changeLoadingScreenStatus() {
    loadingScreenStatusInput.add(screenState == ScreenStatusState.loading);
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
      makeFilter("email already", 'email already exists');
      makeFilter("invalid email", 'enter valid email');
      makeFilter("phone already", 'phone already exists');
      makeFilter("phone", 'phone is required');
      makeFilter("password", 'password is required');
      makeFilter("first name", 'first name is required');
      makeFilter("last name", 'last name is required');
      makeFilter("image", 'image is required');
      makeFilter(
        "password must be at least",
        'password must be at least 12 characters one uppercase letter one lowercase letter one special character and one number',
      );
      makeFilter(
        "LateInitializationError: Local 'conn' has not been initialized",
        "please open xampp app",
      );
    }

    return errorList.join(" , ");
  }

  void _requestMakeNewUser(BuildContext context) async {
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
        _OnFailureRequest(l, context);
      },
      (AuthResponse r) {
        _OnSuccessResquest(r, context);
      },
    );
    changeLoadingScreenStatus();
  }
}
