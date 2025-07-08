import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<File?> pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
    );
   return image == null ? null : File(image.path);
  }
}