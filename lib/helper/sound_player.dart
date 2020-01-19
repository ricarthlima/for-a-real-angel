import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';

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

  SoundPlayer() {
    _poolAlarm = Soundpool(streamType: StreamType.music);
    _loadSounds();
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
}
