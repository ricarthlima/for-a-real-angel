import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/localizations.dart';
import 'package:for_a_real_angel_demo/partials/start_menu.dart';
import 'package:for_a_real_angel_demo/values/icons_values.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskBar extends StatefulWidget {
  SoundPlayer soundPlayer;
  TaskBar({this.soundPlayer});
  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  String hour = "";
  bool isSoundActive = true;
  bool isMusicActive = true;

  @override
  void initState() {
    _readPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getHour();
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        height: 40,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    widget.soundPlayer.playClickSound();
                    showStartMenu(context);
                  },
                  child: TaskBarButton(
                    null,
                    AppLocalizations.of(context).start,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 2)),
                // Text(
                //   "|",
                //   style: TextStyle(color: Colors.grey, fontSize: 20),
                // ),
                // Padding(padding: EdgeInsets.only(right: 2)),
                // Image.asset(
                //   "assets/icons/desktop-0.png",
                //   height: 20,
                // ),
                // Padding(padding: EdgeInsets.only(right: 2)),
                // Text(
                //   "|",
                //   style: TextStyle(color: Colors.grey, fontSize: 20),
                // ),
              ],
            ),

            // RELOGIO
            Container(
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 1),
                  left: BorderSide(color: Colors.grey, width: 1),
                  bottom: BorderSide(color: Colors.white, width: 1),
                  right: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _switchSoundActive();
                    },
                    child: Image.asset(
                      (isSoundActive)
                          ? IconsValues.speaker_on
                          : IconsValues.speaker_off,
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                  GestureDetector(
                    onTap: () {
                      _switchMusicActive();
                    },
                    child: Image.asset(
                      (isMusicActive)
                          ? IconsValues.music_on
                          : IconsValues.music_off,
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                  ),
                  Text(
                    hour,
                    style: TextStyle(
                        color: Colors.black, fontFamily: "CourierPrime"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isAct = prefs.getBool(PreferencesKey.isSoundActive);
    final isMusicAct = prefs.getBool(PreferencesKey.isMusicActive);

    if (isAct != null) {
      setState(() {
        this.isSoundActive = isAct;
      });
    } else {
      setState(() {
        this.isSoundActive = true;
        prefs.setBool(PreferencesKey.isSoundActive, true);
      });
    }

    setState(() {
      if (isMusicAct != null) {
        this.isMusicActive = isMusicAct;
      } else {
        this.isMusicActive = true;
        prefs.setBool(PreferencesKey.isMusicActive, true);
      }
    });
  }

  _switchSoundActive() async {
    setState(() {
      this.isSoundActive = !this.isSoundActive;
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.isSoundActive, this.isSoundActive);

    if (this.isSoundActive) {
      widget.soundPlayer.playExitSound();
    }
  }

  _switchMusicActive() async {
    setState(() {
      this.isMusicActive = !this.isMusicActive;
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.isMusicActive, this.isMusicActive);

    if (this.isMusicActive) {
      widget.soundPlayer.playBGM();
    } else {
      widget.soundPlayer.stopBGM();
    }
  }

  _getHour() {
    setState(() {
      hour = DateTime.now().hour.toString() + ":";
      if (DateTime.now().minute < 10) {
        hour = hour + "0";
      }
      hour = hour + DateTime.now().minute.toString();
    });
  }
}

class TaskBarButton extends StatefulWidget {
  final String icon;
  final String text;

  TaskBarButton(this.icon, this.text);
  @override
  _TaskBarButtonState createState() => _TaskBarButtonState();
}

class _TaskBarButtonState extends State<TaskBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
          right: BorderSide(color: Colors.black, width: 1),
          top: BorderSide(color: Colors.white, width: 1),
          left: BorderSide(color: Colors.white, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          (widget.icon != null)
              ? Image.asset(
                  widget.icon,
                  height: 20,
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(right: 2),
          ),
          Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                fontFamily: "CourierPrime"),
          ),
        ],
      ),
    );
  }
}
