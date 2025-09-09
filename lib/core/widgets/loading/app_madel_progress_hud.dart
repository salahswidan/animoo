import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../resources/colors_manager.dart';

class AppModelProgressHud extends StatelessWidget {
  const AppModelProgressHud({super.key, required this.loadingOutputStream, required this.child});
  final Stream<bool> loadingOutputStream;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: loadingOutputStream,
      initialData: false,
      builder: (context, snapshot) =>
       ModalProgressHUD(
        inAsyncCall: snapshot.data ?? false,
        dismissible: false,
        progressIndicator: const CupertinoActivityIndicator(
          color: ColorManager.kPrimaryColor,
        ),
      
        blur: 5,
        child: child,
      ),
    );
    
  }
}
