import 'package:animoo/view/forget_password/widgets/forget_password_app_bar.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ForgetPasswordAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(children: []),
          ),
        ),
      ),
    );
  }
}
