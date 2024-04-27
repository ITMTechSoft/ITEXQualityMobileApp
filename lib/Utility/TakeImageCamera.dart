import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<String?> TakeImageFromCamera(
    {double maxHeight = 1600, double maxWidth = 1600, int quality = 100}) async {
  String? ImageString64="";
  try{
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: quality,
    );



    if (imageFile != null){
      final bytes = imageFile!=null? File(imageFile.path).readAsBytesSync():null;
      ImageString64 =base64Encode(bytes!);
    }

  }catch(e){
    print(e);
  }


  return ImageString64;
}

