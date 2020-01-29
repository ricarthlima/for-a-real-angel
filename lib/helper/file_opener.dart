import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/model/mfile.dart';
import 'package:for_a_real_angel_demo/screens/image_viewer.dart';

routerFileType({
  @required MFile file,
  @required BuildContext context,
  @required SoundPlayer soundPlayer,
}) {
  switch (file.type) {
    case MFileTypes.image:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewer(
            file: file,
            soundPlayer: soundPlayer,
          ),
        ),
      );
      break;
    case MFileTypes.text:
      break;
    case MFileTypes.audio:
      soundPlayer.playMusicWithDialog(
        context: context,
        file: file,
      );
      break;
    case MFileTypes.other:
      break;
  }
}
