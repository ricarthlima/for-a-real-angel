import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SoundPlayer extends ChangeNotifier {
  final AudioPlayer _playerBGM = AudioPlayer();
  final AudioPlayer _playerSFX = AudioPlayer();

  playBGM() async {
    _playerBGM.setUrl("asset:///assets/music/mainbgm.mp3").then((value) {
      _playerBGM.play();
    });
  }

  stopBGM() {
    _playerBGM.stop();
  }

  void playSFX(String soundPath) async {
    final prefs = await SharedPreferences.getInstance();
    final isAct = prefs.getBool(PreferencesKey.isSoundActive);

    if (isAct == null || isAct) {
      if (isAct == null) {
        prefs.setBool(PreferencesKey.isSoundActive, true);
      }

      //here
      _playerSFX
          .setUrl("asset:///assets/sounds/$soundPath")
          .then((value) => _playerSFX.play());
    }
  }

  playMusic(String path) {
    final tempPlayer = AudioPlayer();
    tempPlayer.setUrl(path);
    tempPlayer.play();
  }

  playMusicWithDialog({
    required BuildContext context,
    required MFile file,
  }) async {
    String path = "files/${file.filePath!}";
    final tempPlayer = AudioPlayer();
    tempPlayer.setUrl(path);
    tempPlayer.play();
    int duration = 0;
    int position = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (content, setState) {
          tempPlayer.bufferedPositionStream.listen((Duration d) {
            setState(() => duration = d.inMilliseconds);
          });
          tempPlayer.bufferedPositionStream.listen((Duration p) {
            setState(() => position = p.inMilliseconds);
          });
          return AlertDialog(
            title: Text(path.split("/").removeLast()),
            content: Container(
              height: 50,
              child: Slider(
                onChanged: (time) {},
                min: -5,
                max: (duration / 1) + 5,
                value: position / 1,
              ),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      tempPlayer.play();
                    },
                    child: Icon(Icons.play_arrow),
                  ),
                  FlatButton(
                    onPressed: () {
                      tempPlayer.pause();
                    },
                    child: Icon(Icons.pause),
                  ),
                  FlatButton(
                    onPressed: () {
                      tempPlayer.stop();
                    },
                    child: Icon(Icons.stop),
                  ),
                  FlatButton(
                    onPressed: () {
                      _launchURL(file.downlink!);
                    },
                    child: Icon(Icons.cloud_download),
                  ),
                ],
              )
            ],
          );
        });
      },
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
