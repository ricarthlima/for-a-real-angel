import 'dart:io';

import 'package:flutter/material.dart';
import 'package:for_a_real_angel/simple_cap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterSplash extends StatefulWidget {
  @override
  _ChapterSplashState createState() => _ChapterSplashState();
}

class _ChapterSplashState extends State<ChapterSplash> {
  int idChapter;

  @override
  void initState() {
    _read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _justWait(numberOfSeconds: 3);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.ac_unit,
              size: 45,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Text(
              "Episódio " + ((idChapter ~/ 5.1) + 1).toString(),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Future _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'chapter_id';
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
        context, MaterialPageRoute(builder: (context) => SimpleCap()));
  }
}
