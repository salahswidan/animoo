import 'package:flutter/material.dart';

class SignUpController {
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool visiblePassword = false;

  bool visibleConfirmPassword = false;

  @override
  void initState() {
    //? init Controllers
    initControllers();
  }
 void dispose(){
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
}
