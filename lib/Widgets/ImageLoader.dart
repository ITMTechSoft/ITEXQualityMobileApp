import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';


class ImageLoader extends StatefulWidget {
  Future<String?> LoadingImage;
  ImageLoader({Key? key,required this.LoadingImage}) : super(key: key);

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  int IntiteStatus = 0;

  Widget GetImage(String base64Image) {
    if (base64Image.isNotEmpty && base64Image !="") {
      try {
        final Uint8List _byteImage = Base64Decoder().convert(base64Image.trim());

        return Image.memory(
          _byteImage,
          height: ArgonSize.ImageHeight,
          width: ArgonSize.ImageHeight,
          alignment: Alignment.center,
        );
      } catch (e) {
        print('Error loading image: $e');
      }
    }

    return Icon(Icons.image);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.LoadingImage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String base64Image = snapshot.data.toString();
          try {
            final _byteImage = Base64Decoder().convert(base64Image.trim());
            return GetImage(base64Image);
          } catch (e) {
            print('Error decoding base64 string: $e');
            return Icon(Icons.image);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
