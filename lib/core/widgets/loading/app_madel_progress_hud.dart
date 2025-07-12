import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../resources/colors_manager.dart';

class AppModelProgressHud extends StatelessWidget {
  const AppModelProgressHud({super.key, required this.loading, required this.child});
  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: child,
      inAsyncCall: loading,
      dismissible: false,
      progressIndicator: const CupertinoActivityIndicator(
        color: ColorManager.kPrimaryColor,
      ),

      blur: 5,
    );
    
  }
}
