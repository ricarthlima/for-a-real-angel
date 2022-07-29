import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/partials/start_menu.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/values/sounds.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({Key? key}) : super(key: key);

  @override
  State<TaskBar> createState() => _TaskBarState();
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
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          color: const Color.fromARGB(255, 192, 192, 192),
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
                    context.read<SoundPlayer>().playSFX(Sounds.idClick);
                    showStartMenu(context);
                  },
                  child: TaskBarButton(
                    null,
                    AppLocalizations.of(context)!.start,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 2)),
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
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: const BoxDecoration(
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
                          ? IconsValues.speakerOn
                          : IconsValues.speakerOff,
                      height: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                  GestureDetector(
                    onTap: () {
                      _switchMusicActive();
                    },
                    child: Image.asset(
                      (isMusicActive)
                          ? IconsValues.musicOn
                          : IconsValues.musicOff,
                      height: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                  ),
                  Text(
                    hour,
                    style: const TextStyle(
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
        isSoundActive = isAct;
      });
    } else {
      setState(() {
        isSoundActive = true;
        prefs.setBool(PreferencesKey.isSoundActive, true);
      });
    }

    setState(() {
      if (isMusicAct != null) {
        isMusicActive = isMusicAct;
      } else {
        isMusicActive = true;
        prefs.setBool(PreferencesKey.isMusicActive, true);
      }
    });
  }

  _switchSoundActive() async {
    setState(() {
      isSoundActive = !isSoundActive;
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.isSoundActive, isSoundActive);

    if (isSoundActive) {
      context.read<SoundPlayer>().playSFX(Sounds.idExit);
    }
  }

  _switchMusicActive() async {
    setState(() {
      isMusicActive = !isMusicActive;
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.isMusicActive, isMusicActive);

    if (isMusicActive) {
      context.read<SoundPlayer>().playBGM();
    } else {
      context.read<SoundPlayer>().stopBGM();
    }
  }

  _getHour() {
    setState(() {
      hour = "${DateTime.now().hour}:";
      if (DateTime.now().minute < 10) {
        hour = "${hour}0";
      }
      hour = hour + DateTime.now().minute.toString();
    });
  }
}

class TaskBarButton extends StatefulWidget {
  final String? icon;
  final String text;

  const TaskBarButton(this.icon, this.text, {Key? key}) : super(key: key);

  @override
  State<TaskBarButton> createState() => _TaskBarButtonState();
}

class _TaskBarButtonState extends State<TaskBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 30,
      decoration: const BoxDecoration(
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
                  widget.icon!,
                  height: 20,
                )
              : Container(),
          const Padding(
            padding: EdgeInsets.only(right: 2),
          ),
          Text(
            widget.text,
            style: const TextStyle(
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
