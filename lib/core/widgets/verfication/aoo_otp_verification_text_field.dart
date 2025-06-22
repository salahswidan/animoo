
import 'package:animoo/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOtpVerificationTextField extends StatefulWidget {
  const AppOtpVerificationTextField({super.key, required this.onCompleted});
  final void Function(String value) onCompleted;

  @override
  State<AppOtpVerificationTextField> createState() =>
      _AppOtpVerificationTextFieldState();
}

class _AppOtpVerificationTextFieldState
    extends State<AppOtpVerificationTextField> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4; 
  late TextEditingController controller5;

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();

    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode1);
    });
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
  }

  void goToNextFocusNode(
    String value,
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    if (value.trim().isNotEmpty) {
      if (value.length > 1) {
        controller.text = value[value.length - 1];
      }
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,

            focusNode: focusNode1,
            onChanged: (value) {
              goToNextFocusNode(value, focusNode2, controller1);
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomTextFormField(
            controller: controller2,
            keyboardType: TextInputType.number,

            textAlign: TextAlign.center,
            focusNode: focusNode2,
            onChanged: (value) {
              goToNextFocusNode(value, focusNode3, controller2);
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomTextFormField(
            controller: controller3,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,

            focusNode: focusNode3,
            onChanged: (value) {
              goToNextFocusNode(value, focusNode4, controller3);
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomTextFormField(
            controller: controller4,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            focusNode: focusNode4,
            onChanged: (value) {
              goToNextFocusNode(value, focusNode5, controller4);
            },
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomTextFormField(
            controller: controller5,
            keyboardType: TextInputType.number,

            textAlign: TextAlign.center,
            focusNode: focusNode5,
            onChanged: (value) {
              if (value.trim().isNotEmpty) {
                  if (value.length > 1) {
                controller5.text = value[value.length - 1];
              }
                FocusScope.of(context).unfocus();
                              widget.onCompleted(controller1.text.trim() + controller2.text.trim() + controller3.text.trim() + controller4.text.trim() + controller5.text.trim());

              }
            
            },
          ),
        ),
      ],
    );
  }
}
