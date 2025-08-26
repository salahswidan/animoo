import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/widgets/app_bar/simple_app_bar.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/custom_required_field.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: ConstsValuesManager.back),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(HeightsManager.h9_15),
                Text(
                  ConstsValuesManager.forgetYourPassword,
                  style: TextStyle(
                    fontFamily: FontsManager.otamaEpFontFamily,
                    fontSize: FontSizeManager.s20,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                VerticalSpace(HeightsManager.h6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw4),
                  child: Text(
                    style: TextStyle(
                      fontFamily: FontsManager.poppinsFontFamily,
                      fontSize: FontSizeManager.s14,
                      color: ColorManager.kGrey4Color,
                    ),
                    ConstsValuesManager
                        .pleaseEnterTheEmailAddressAssociatedWithYourAccountAndWeWillSendYouOtpToResetYourPassword,
                  ),
                ),
                VerticalSpace(HeightsManager.h58),
                CustomRequiredField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: TextEditingController(),
                  title: ConstsValuesManager.email,
                  hintText: ConstsValuesManager.enterYourEmailAddress,
                ),
                VerticalSpace(HeightsManager.h151),
                AppButton(
                  text: ConstsValuesManager.sendCode,
                  onTap: () {
                    //?go to otp page
                    Navigator.of(
                      context,
                    ).pushNamed(RoutesName.otpVerificationScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
