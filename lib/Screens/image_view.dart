// import 'dart:html';
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import 'package:heartbeat/constants/dummy_lists.dart';
// import 'package:heartbeat/providers/db_helper.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:provider/provider.dart';

class ImageViewScreen extends StatelessWidget {
  ImageViewScreen(this.img, {super.key});
  String img;
  // final imageLoc;
  // ImageViewScreen(this.imageLoc);
  // const ImageViewScreen({ Key? key }) : super(key: key);

  static const String routeName = 'imageviewscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        // maxScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        // enableRotation: true,
        imageProvider: NetworkImage(
          img.toString(),
        ),
      ),
    );
  }
}
