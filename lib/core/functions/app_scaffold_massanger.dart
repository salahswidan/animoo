import 'package:flutter/material.dart';

void showAppSnackBar(BuildContext context, String message,
{VoidCallback? onPressedAtRetry}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
  showCloseIcon: true ,
  action: onPressedAtRetry == null ? null : SnackBarAction(
    label: 'Retry',
    onPressed: onPressedAtRetry,
  )));
}
