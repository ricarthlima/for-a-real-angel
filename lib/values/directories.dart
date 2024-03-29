import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/icons_values.dart';

class Directories {
  static const MFolder recycleBin =
      MFolder(chapter: 0, title: "Recycle Bin", listFiles: [], listFolders: []);

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
          downlink: "wing.jpg",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "mouth.jpg",
          type: MFileTypes.image,
          filePath: "mouth.jpg",
          downlink: "mouth.jpg",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "fur.jpg",
          type: MFileTypes.image,
          filePath: "fur.jpg",
          downlink: "fur.jpg",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "eyes.jpg",
          type: MFileTypes.image,
          filePath: "eyes.jpg",
          downlink: "eyes.jpg",
        ),
      ],
    ),
    MFolder(chapter: 0, title: "Memories", listFiles: [], listFolders: [
      MFolder(chapter: 0, title: "Andrew", listFiles: [
        MFile(
            chapter: 0,
            icon: IconsValues.soul,
            title: "97 110 100 114 101 119",
            type: MFileTypes.andrew),
        MFile(
          chapter: 6,
          title: "map.png",
          icon: IconsValues.image,
          type: MFileTypes.image,
          filePath: "map.png",
          downlink: "map.png",
        ),
        MFile(
          chapter: 7,
          title: "message.mp3",
          icon: IconsValues.musicOn,
          type: MFileTypes.audio,
          filePath: "files/message.mp3",
          downlink: "message.mp3",
        ),
        MFile(
          chapter: 9,
          title: "call.jpg",
          icon: IconsValues.image,
          type: MFileTypes.image,
          filePath: "message2.jpg",
          downlink: "message2.jpg",
        ),
      ], listFolders: [])
    ]),
  ], listFiles: [
    MFile(
        chapter: 5,
        icon: IconsValues.image,
        title: "unknow.jpg",
        type: MFileTypes.image,
        filePath: "unknow.jpg",
        downlink: "unknow.jpg")
  ]);
}
