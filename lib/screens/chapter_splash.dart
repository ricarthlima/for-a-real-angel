import 'package:flutter/material.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/screens/desktop_context_screen.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterSplash extends StatefulWidget {
  const ChapterSplash({Key? key}) : super(key: key);

  @override
  State<ChapterSplash> createState() => _ChapterSplashState();
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
      idEpisode = (idChapter ~/ 5.1) + 1;
    });

    //widget.soundPlayer!.playSuccessSound();
    _justWait(numberOfSeconds: 4);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              (idEpisode == 1)
                  ? Icons.ac_unit
                  : (idEpisode == 2)
                      ? Icons.leak_remove
                      : Icons.lens,
              size: 45,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Text(
              "${AppLocalizations.of(context)!.episode} ${(idChapter ~/ 5.1) + 1}",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Future _read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = PreferencesKey.chapterId;
    final value = prefs.getInt(key);

    if (value != null) {
      setState(() {
        idChapter = value;
      });
    } else {
      setState(() {
        idChapter = 1;
      });
    }
  }

  void _justWait({required int numberOfSeconds}) async {
    await Future.delayed(Duration(seconds: numberOfSeconds));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DesktopContextScreen(),
      ),
    );
  }
}
