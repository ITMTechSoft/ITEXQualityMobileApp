import 'dart:convert';

import 'package:flutter/material.dart';


class ImageLoader extends StatefulWidget {
  Future<String?> LoadingImage;
  ImageLoader({Key? key,required this.LoadingImage}) : super(key: key);

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  int IntiteStatus = 0;

  Widget GetImage(String  base64Image){
    final _byteImage = Base64Decoder().convert(base64Image);
    return Image.memory(_byteImage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.LoadingImage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetImage(snapshot.data.toString());
        } else
          return Center(child: CircularProgressIndicator());

      },
    );
  }
}

