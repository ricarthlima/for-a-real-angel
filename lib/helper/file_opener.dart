import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/screens/image_viewer.dart';

routerFileType(MFile file, BuildContext context) {
  switch (file.type) {
    case MFileTypes.image:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewer(
            file: file,
          ),
        ),
      );
      break;
    case MFileTypes.text:
      break;
    case MFileTypes.audio:
      break;
    case MFileTypes.other:
      break;
  }
}
