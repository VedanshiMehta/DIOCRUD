import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget {
  ImagePickerWidget._();
  static Future<File?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (ex) {
      debugPrint(ex.message);
      return null;
    }
  }
}
