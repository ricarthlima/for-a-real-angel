import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:for_a_real_angel/helper/custom_dialog.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/screens/desktop_screen.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/partials/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/laucher_url.dart';
import '../values/sounds.dart';

class DesktopContextScreen extends StatefulWidget {
  DesktopContextScreen();
  @override
  _DesktopContextScreenState createState() => _DesktopContextScreenState();
}

class _DesktopContextScreenState extends State<DesktopContextScreen>
    with AfterLayoutMixin<DesktopContextScreen> {
  String wallpaper = "assets/wallpaper-def.png";

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _versionVerification(context);
    if (Localizations.localeOf(context).languageCode == "en") {
      setState(() {
        this.wallpaper = "assets/wallpaper-def-en.png";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onPanUpdate: (details) {
              // Swiping in right direction.
              if (details.delta.dx > 0) {
                _normalizarWallpaper(context);
              }

              // Swiping in left direction.
              if (details.delta.dx < 0) {
                _inverterWallpaper(context);
              }
            },
            child: Center(
              child: Image.asset(
                this.wallpaper,
                height: size.height,
                fit: BoxFit.none,
              ),
            ),
          ),
          DesktopScreen(),
          TaskBar(),
        ],
      ),
    );
  }

  void _inverterWallpaper(BuildContext context) {
    setState(() {
      this.wallpaper = "assets/wallpaper-inv.png";
      if (Localizations.localeOf(context).languageCode == "en") {
        this.wallpaper = "assets/wallpaper-inv-en.png";
      }
    });

    context.read<SoundPlayer>().playSFX(Sounds.idGetHint);
  }

  void _normalizarWallpaper(BuildContext context) {
    setState(() {
      this.wallpaper = "assets/wallpaper-def.png";
      if (Localizations.localeOf(context).languageCode == "en") {
        this.wallpaper = "assets/wallpaper-def-en.png";
      }
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
              getFromStorage(
                context,
                "https://play.google.com/store/apps/details?id=com.ricarthlima.for_a_real_angel",
              );
            },
            child: Text(
              AppLocalizations.of(context)!.update,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]);
  }
}
