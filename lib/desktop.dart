import 'dart:convert';

import 'package:after_layout/after_layout.dart';
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

class _DesktopState extends State<Desktop> with AfterLayoutMixin<Desktop> {
  String wallpaper = "assets/wallpaper-def.png";

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _versionVerification(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

  void _versionVerification(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final versionPrefs = prefs.getString(PreferencesKey.newVersion);
    if (versionPrefs != null) {
      _showVersionDialog(context, versionPrefs);
    }
  }

  void _showVersionDialog(BuildContext context, String versionPrefs) async {
    print(versionPrefs.toString());
    Map<String, dynamic> versionQuery = jsonDecode(versionPrefs);
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
