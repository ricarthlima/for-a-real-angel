import 'dart:math';

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
      _playerBGM.setLoopMode(LoopMode.all).then((value) {
        _playerBGM.play();
      });
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
    tempPlayer.setUrl("asset:///assets/$path");
    tempPlayer.play();
  }

  playMusicWithDialog({
    required BuildContext context,
    required MFile file,
  }) async {
    String path = "asset:///assets/${file.filePath!}";

    final tempPlayer = AudioPlayer();
    await tempPlayer.setUrl(path);
    tempPlayer.play();

    Duration duration = tempPlayer.duration!;
    Duration position = duration;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (content, setState) {
            tempPlayer.positionStream.listen((Duration d) {
              setState(
                () {
                  position = d;
                },
              );
            });
            return AlertDialog(
              title: Text(path.split("/").removeLast()),
              content: SizedBox(
                height: 50,
                child: Slider(
                  onChanged: (v) {
                    tempPlayer.seek(
                      Duration(
                        microseconds: (duration.inMicroseconds * v).floor(),
                      ),
                    );
                  },
                  value:
                      min(1, position.inMicroseconds / duration.inMicroseconds),
                ),
              ),
              actions: <Widget>[
                Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        if (tempPlayer.playing) {
                          tempPlayer.pause();
                        } else {
                          tempPlayer.play();
                        }
                      },
                      child: (tempPlayer.playing)
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                    ),
                    TextButton(
                      onPressed: () {
                        tempPlayer.stop();
                      },
                      child: const Icon(Icons.stop),
                    ),
                    TextButton(
                      onPressed: () {
                        tempPlayer.seek(Duration.zero);
                        tempPlayer.play();
                      },
                      child: const Icon(Icons.replay),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchURL(file.downlink!);
                      },
                      child: const Icon(Icons.cloud_download),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}

_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
