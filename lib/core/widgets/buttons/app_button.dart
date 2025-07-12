import 'package:animoo/core/enums/button_states_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_values_manager.dart';
import '../../resources/border_radius_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/fonts_size_manager.dart';
import '../../resources/heights_manager.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.height,
    this.textColor,
    this.fontSize,
    this.borderRadius,
    this.buttonStatus,
  });

  final String text;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final ButtonStatesEnum? buttonStatus;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          buttonStatus == ButtonStatesEnum.loading ||
                  buttonStatus == ButtonStatesEnum.disabled
              ? null
              : onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height ?? HeightsManager.h44),

        backgroundColor: backgroundColor ?? ColorManager.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(BorderRadiusManager.br5),
        ),
      ),
      child:
          buttonStatus == ButtonStatesEnum.loading
              ? Center(
                child: const CupertinoActivityIndicator(
                  color: ColorManager.kPrimaryColor,
                ),
              )
              : Text(
                text,
                style: TextStyle(
                  color: textColor ?? ColorManager.kWhiteColor,
                  fontFamily: FontsManager.poppinsFontFamily,
                  fontSize: fontSize ?? FontSizeManager.s14,
                ),
              ),
    );
  }
}
