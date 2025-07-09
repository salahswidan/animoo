import 'dart:io';

import 'package:animoo/core/enums/select_image_status.dart';
import 'package:animoo/core/functions/image_picker_service.dart';
import 'package:animoo/core/resources/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/resources/const_values.dart';

class SignUpController {
  SelectImageStatus selectImageStatus = SelectImageStatus.normal;
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool visiblePassword = true;

  bool visibleConfirmPassword = true;

  File? fileImage;

  @override
  void initState() {
    //? init Controllers
    initControllers();
  }

  void dispose() {
    //? dispose Controllers
    disposeControllers();
  }

  void initControllers() {
    formKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void disposeControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  SignUpController() {
    initState();
  }

  void _changeRule(int index, bool value) {
    ConstsListManager.passwordRulesRequirements[index]['valid'] = value;
  }

  void onChangedPassword(String value) {
    passwordController.text = passwordController.getText;
    if (value.trim().length < 12) {
      _changeRule(0, false);
    } else {
      _changeRule(0, true);
    }
    if (!value.trim().contains(RegExp(r"[A-Z]"))) {
      _changeRule(1, false);
    } else {
      _changeRule(1, true);
    }

    if (!value.trim().contains(RegExp(r"[a-z]"))) {
      _changeRule(2, false);
    } else {
      _changeRule(2, true);
    }

    if (!value.trim().contains(RegExp(r"[a-z]"))) {
      _changeRule(2, false);
    } else {
      _changeRule(2, true);
    }

    if (!value.trim().contains(RegExp(r"[!@#\$&*~]"))) {
      _changeRule(3, false);
    } else {
      _changeRule(3, true);
    }
    if (!value.trim().contains(RegExp(r"[0-9]"))) {
      _changeRule(4, false);
    } else {
      _changeRule(4, true);
    }
  }

  void onTapAtSelectImage() async {
    fileImage = await ImagePickerService.pickImage(source: ImageSource.camera);
    if (fileImage == null) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    } else {
      selectImageStatus = SelectImageStatus.imageSelected;
    }
  }

  void onTapSignUp() {
    if(selectImageStatus == SelectImageStatus.normal) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    }
    if (formKey.currentState!.validate() && 
        selectImageStatus == SelectImageStatus.imageSelected) {
      print("validate");
    }
  }
}
