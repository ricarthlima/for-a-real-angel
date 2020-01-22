import 'dart:convert';

import 'package:for_a_real_angel/helper/customDialog.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/screens/desktop_screen.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/visual_objects/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:url_launcher/url_launcher.dart';

class Desktop extends StatefulWidget {
  SoundPlayer soundPlayer;
  Desktop({this.soundPlayer});
  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  String wallpaper = "assets/wallpaper-def.png";
  String versionPrefs;

  @override
  void initState() {
    _versionVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showVersionDialog(context));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SwipeDetector(
            onSwipeLeft: () {
              _inverterWallpaper();
            },
            onSwipeRight: () {
              _normalizarWallpaper();
            },
            child: Center(
              child: Image.asset(
                this.wallpaper,
                height: size.height,
                fit: BoxFit.none,
              ),
            ),
          ),
          DesktopScreen(
            soundPlayer: widget.soundPlayer,
          ),
          TaskBar(
            soundPlayer: widget.soundPlayer,
          ),
        ],
      ),
    );
  }

  void _inverterWallpaper() {
    setState(() {
      this.wallpaper = "assets/wallpaper-inv.png";
    });
    this.widget.soundPlayer.playGetHintSound();
  }

  void _normalizarWallpaper() {
    setState(() {
      this.wallpaper = "assets/wallpaper-def.png";
    });
  }

  void _versionVerification() async {
    final prefs = await SharedPreferences.getInstance();
    final versionPrefs = prefs.getString(PreferencesKey.newVersion);
    if (versionPrefs != null) {
      setState(() {
        this.versionPrefs = versionPrefs;
      });
    } else {
      setState(() {
        this.versionPrefs = null;
      });
    }
  }

  void _showVersionDialog(BuildContext context) async {
    if (this.versionPrefs != null) {
      Map<String, dynamic> versionQuery = jsonDecode(this.versionPrefs);
      showMyCustomDialog(
          context: context,
          title: Text(versionQuery["title"]),
          content:
              Text(versionQuery["message"].toString().replaceAll("/n", "\n")),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _launchURL(
                  "https://play.google.com/store/apps/details?id=com.ricarthlima.for_a_real_angel",
                );
              },
              child: Text(
                "Atualizar",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]);
    }

    setState(() {
      this.versionPrefs = null;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
