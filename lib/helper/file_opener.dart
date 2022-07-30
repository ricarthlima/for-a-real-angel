import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/screens/image_viewer_screen.dart';
import 'package:provider/provider.dart';

import '../screens/andrew_chapters_screen.dart';

openFile({
  required MFile file,
  required BuildContext context,
}) {
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
      context.read<SoundPlayer>().playMusicWithDialog(
            context: context,
            file: file,
          );
      break;
    case MFileTypes.other:
      break;
    case MFileTypes.andrew:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AndrewChaptersScreen(),
        ),
      );
      break;
  }
}
