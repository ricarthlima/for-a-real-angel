import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/icons_values.dart';

class Directories {
  static const MFolder recycleBin =
      MFolder(chapter: 0, title: "recycleBin", listFiles: [], listFolders: []);

  static const MFolder documents =
      MFolder(chapter: 0, title: "Documents", listFolders: [
    MFolder(
      chapter: 0,
      title: "Base Specimens",
      listFolders: [],
      listFiles: [
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "wing.jpg",
          type: MFileTypes.image,
          filePath: "wing.jpg",
          downlink: "",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "mouth.jpg",
          type: MFileTypes.image,
          filePath: "mouth.jpg",
          downlink: "",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "fur.jpg",
          type: MFileTypes.image,
          filePath: "fur.jpg",
          downlink: "",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "eyes.jpg",
          type: MFileTypes.image,
          filePath: "eyes.jpg",
          downlink: "",
        ),
      ],
    ),
  ], listFiles: [
    MFile(
        chapter: 5,
        icon: IconsValues.image,
        title: "unknow.jpg",
        type: MFileTypes.image)
  ]);
}
