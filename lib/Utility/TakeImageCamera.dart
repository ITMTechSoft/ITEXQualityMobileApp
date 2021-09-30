import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<String?> TakeImageFromCamera(
    {double maxHeight = 150, double maxWidth = 150, int quality = 100}) async {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile = await _picker.pickImage(
    source: ImageSource.camera,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: quality,
  );

  String? ImageString64="";
  if (imageFile != null){
    final bytes = imageFile!=null? File(imageFile.path).readAsBytesSync():null;
    ImageString64 =base64Encode(bytes!);
  }


  return ImageString64;
}

