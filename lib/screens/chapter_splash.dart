import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/screens/desktop_context_screen.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:for_a_real_angel_demo/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterSplash extends StatefulWidget {
  SoundPlayer soundPlayer;
  ChapterSplash({this.soundPlayer});

  @override
  _ChapterSplashState createState() => _ChapterSplashState();
}

class _ChapterSplashState extends State<ChapterSplash> {
  int idChapter = 0;
  int idEpisode = 0;

  @override
  void initState() {
    _read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      this.idEpisode = (idChapter ~/ 5.1) + 1;
    });

    widget.soundPlayer.playSuccessSound();
    _justWait(numberOfSeconds: 4);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              (this.idEpisode == 1)
                  ? Icons.ac_unit
                  : (this.idEpisode == 2) ? Icons.leak_remove : Icons.lens,
              size: 45,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Text(
              AppLocalizations.of(context).episode +
                  " " +
                  ((idChapter ~/ 5.1) + 1).toString(),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Future _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.chapterId;
    final value = prefs.getInt(key);

    if (value != null) {
      setState(() {
        this.idChapter = value;
      });
    } else {
      setState(() {
        this.idChapter = 1;
      });
    }
  }

  void _justWait({@required int numberOfSeconds}) async {
    await Future.delayed(Duration(seconds: numberOfSeconds));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DesktopContextScreen(
          soundPlayer: widget.soundPlayer,
        ),
      ),
    );
  }
}
