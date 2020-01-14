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
