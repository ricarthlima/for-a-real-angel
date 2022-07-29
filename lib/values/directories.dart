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
          filePath: "n2/wing.jpg",
          downlink: "https://projeto-k22b.herokuapp.com/files/n2/wing.jpg",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "mouth.jpg",
          type: MFileTypes.image,
          filePath: "n2/mouth.jpg",
          downlink: "https://projeto-k22b.herokuapp.com/files/n2/mouth.jpg",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "fur.jpg",
          type: MFileTypes.image,
          filePath: "n2/fur.jpg",
          downlink: "https://projeto-k22b.herokuapp.com/files/n2/fur.jpg",
        ),
        MFile(
          chapter: 0,
          icon: IconsValues.image,
          title: "eyes.jpg",
          type: MFileTypes.image,
          filePath: "n2/eyes.jpg",
          downlink: "https://projeto-k22b.herokuapp.com/files/n2/eyes.jpg",
        ),
      ],
    ),
    MFolder(chapter: 0, title: "Memories", listFiles: [], listFolders: [
      MFolder(chapter: 0, title: "Andrew", listFiles: [
        MFile(
          chapter: 6,
          title: "map.png",
          icon: IconsValues.image,
          type: MFileTypes.image,
          filePath: "map.png",
          downlink: "https://projeto-k22b.herokuapp.com/files/map.png",
        ),
        MFile(
          chapter: 7,
          title: "message.mp3",
          icon: IconsValues.musicOn,
          type: MFileTypes.audio,
          filePath: "files/message.mp3",
          downlink: "https://projeto-k22b.herokuapp.com/files/message.mp3",
        ),
        MFile(
          chapter: 8,
          title: "message2.jpg",
          icon: IconsValues.image,
          type: MFileTypes.image,
          filePath: "message2.jpg",
          downlink: "https://projeto-k22b.herokuapp.com/files/message2.jpg",
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
        downlink: "https://projeto-k22b.herokuapp.com/files/unknow.jpg")
  ]);
}
