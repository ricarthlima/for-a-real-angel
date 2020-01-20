import 'dart:typed_data';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';
import 'package:url_launcher/url_launcher.dart';

class SoundPlayer {
  Soundpool _poolAlarm;
  int _idSuccess;
  int _idError;
  int _idPage;
  int _idExit;
  int _idFolder;
  int _idClick;
  int _idCloseTry;
  int _idGetHint;

  final _player = AudioCache(prefix: 'music/');
  AudioPlayer _playingBGM;

  SoundPlayer() {
    _poolAlarm = Soundpool(streamType: StreamType.music);
    _loadSounds();
    _loadMusic();
  }

  void _playSound({@required int soundId}) async {
    final prefs = await SharedPreferences.getInstance();
    final isAct = prefs.getBool(PreferencesKey.isSoundActive);

    if (isAct == null || isAct) {
      if (isAct == null) {
        prefs.setBool(PreferencesKey.isSoundActive, true);
      }
      await _poolAlarm.play(soundId);
    }
  }

  void playPageSound() async {
    _playSound(soundId: this._idPage);
  }

  void playErrorSound() async {
    _playSound(soundId: this._idError);
  }

  void playSuccessSound() async {
    _playSound(soundId: this._idSuccess);
  }

  void playExitSound() async {
    _playSound(soundId: this._idExit);
  }

  void playFolderSound() async {
    _playSound(soundId: this._idFolder);
  }

  void playClickSound() async {
    _playSound(soundId: this._idClick);
  }

  void playCloseTrySound() async {
    _playSound(soundId: this._idCloseTry);
  }

  void playGetHintSound() async {
    _playSound(soundId: this._idGetHint);
  }

  _loadSounds() async {
    this._idSuccess =
        await rootBundle.load("sounds/success.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });

    this._idError =
        await rootBundle.load("sounds/error.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });

    this._idPage =
        await rootBundle.load("sounds/page.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });

    this._idExit =
        await rootBundle.load("sounds/exit.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });

    this._idFolder =
        await rootBundle.load("sounds/folder.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });

    this._idClick =
        await rootBundle.load("sounds/click.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });

    this._idCloseTry =
        await rootBundle.load("sounds/closetry.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });

    this._idGetHint =
        await rootBundle.load("sounds/gethint.mp3").then((ByteData soundData) {
      return _poolAlarm.load(soundData);
    });
  }

  _loadMusic() async {
    this._player.load("mainbgm.mp3");
  }

  playBGM() async {
    this._playingBGM = await this._player.loop("mainbgm.mp3", volume: 0.40);
  }

  stopBGM() {
    this._playingBGM.stop();
  }

  playMusic(String path) {
    final tempPlayer = AudioCache();
    tempPlayer.play(path);
  }

  playMusicWithDialog({
    @required BuildContext context,
    @required MFile file,
  }) async {
    String path = "files/" + file.filePath;
    final tempPlayer = AudioCache();
    AudioPlayer playingMusic = await tempPlayer.play(path);
    playingMusic.resume();
    int duration = 0;
    int position = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (content, setState) {
          playingMusic.onDurationChanged.listen((Duration d) {
            setState(() => duration = d.inMilliseconds);
          });
          playingMusic.onAudioPositionChanged.listen((Duration p) {
            setState(() => position = p.inMilliseconds);
          });
          return AlertDialog(
            title: Text(path.split("/").removeLast()),
            content: Container(
              height: 50,
              child: Slider(
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
                      playingMusic.resume();
                    },
                    child: Icon(Icons.play_arrow),
                  ),
                  FlatButton(
                    onPressed: () {
                      playingMusic.pause();
                    },
                    child: Icon(Icons.pause),
                  ),
                  FlatButton(
                    onPressed: () {
                      playingMusic.stop();
                    },
                    child: Icon(Icons.stop),
                  ),
                  FlatButton(
                    onPressed: () {
                      _launchURL(file.downlink);
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
