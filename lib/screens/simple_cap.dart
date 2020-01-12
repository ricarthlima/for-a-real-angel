import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_a_real_angel/model/chapter.dart';
import 'package:for_a_real_angel/screens/chapter_splash.dart';
import 'package:for_a_real_angel/values/chapters_data.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/visual_objects/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';
import 'package:swipedetector/swipedetector.dart';

class SimpleCap extends StatefulWidget {
  @override
  _SimpleCapState createState() => _SimpleCapState();
}

class _SimpleCapState extends State<SimpleCap> {
  int idChapter = 0;
  int idLastUnlockedChapter = 0;

  // Sound
  Soundpool poolAlarm = Soundpool(streamType: StreamType.music);
  int soundIdSuccess;
  int soundIdError;
  int soundIdPage;

  // Controllers
  ScrollController _controllerScroll;
  TextEditingController _controllerCode = TextEditingController();

  List<Chapter> chapters = [
    Chapter(0, Icons.ac_unit, "", "", "", "-159-"),
    Chapters.cap01,
    Chapters.cap02,
    Chapters.cap03,
    Chapters.cap04,
    Chapters.cap05,
    Chapters.cap06
  ];

  @override
  void initState() {
    idChapter = 0;
    _read();
    _loadSounds();
    _controllerScroll = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Chapter cap = chapters[idChapter];

    return Scaffold(
      appBar: getMenuBar(
        context: context,
        icon: IconsValues.agent,
        title: "Andrew",
      ),
      body: SwipeDetector(
        swipeConfiguration: SwipeConfiguration(
          horizontalSwipeMinVelocity: 100.0,
          horizontalSwipeMinDisplacement: 10.0,
        ),
        onSwipeLeft: () {
          if (this.idChapter < this.idLastUnlockedChapter) {
            _navigateFoward();
          }
        },
        onSwipeRight: () {
          if (this.idChapter > 1) {
            _navigateBack();
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: MyColors.topBlue,
                width: 5,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              controller: _controllerScroll,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.navigate_before,
                          color: (this.idLastUnlockedChapter < 2 ||
                                  this.idChapter < 2)
                              ? Colors.grey
                              : Colors.white,
                        ),
                        onTap: (this.idLastUnlockedChapter < 2 ||
                                this.idChapter < 2)
                            ? () {
                                _navigateError();
                              }
                            : () {
                                _navigateBack();
                              },
                      ),
                      Column(
                        children: <Widget>[
                          Icon(cap.icon),
                          Text(cap.id.toString() + " - " + cap.title),
                        ],
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.navigate_next,
                          color: (this.idChapter >= this.idLastUnlockedChapter)
                              ? Colors.grey
                              : Colors.white,
                        ),
                        onTap: (this.idChapter >= this.idLastUnlockedChapter)
                            ? () {
                                _navigateError();
                              }
                            : () {
                                _navigateFoward();
                              },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    cap.text,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                  ),
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          cap.tipQuote,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                        ),
                        TextField(
                          controller: _controllerCode,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "CourierPrime",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        GestureDetector(
                          onTap: () {
                            _testCode(_controllerCode.text, context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: Text(
                              "RESTAURAR",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "CourierPrime",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        this.idLastUnlockedChapter = value;
      });
    } else {
      setState(() {
        this.idChapter = 1;
        this.idLastUnlockedChapter = 1;
      });
    }
  }

  _testCode(String value, BuildContext context) async {
    bool correct = false;
    int i = 1;
    while (i < chapters.length) {
      if (value.toLowerCase().replaceAll(" ", "") ==
          chapters[i].code.toLowerCase().replaceAll(" ", "")) {
        correct = true;
        break;
      }
      i += 1;
    }

    if (correct) {
      //Play Success SFX
      await poolAlarm.play(this.soundIdSuccess);

      //Scroll screen to top
      _controllerScroll.jumpTo(0.0);

      //Hide keyboard
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      //Save unlocked stage
      _save(chapters[i].id);

      //Change the screen
      setState(() {
        idChapter = chapters[i].id;
        idLastUnlockedChapter = chapters[i].id;
      });

      //Show success dialog
      if (chapters[i].id % 5 == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChapterSplash()));
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("ACESSO AUTORIZADO"),
              titleTextStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              contentTextStyle: TextStyle(color: Colors.black),
              content: Text("Restauração de memória: " +
                  chapters[i].id.toString() +
                  "% concluída."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          },
        );
      }
    } else {
      //Show fail dialog
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("ERRO!"),
              titleTextStyle: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
              contentTextStyle: TextStyle(color: Colors.black),
              content: Text("Código de Restauração Incorreto!"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          });

      //Play fail sound
      await poolAlarm.play(this.soundIdError);
    }
  }

  _save(int chapterId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.chapterId;
    final value = chapterId;
    prefs.setInt(key, value);
  }

  _loadSounds() async {
    this.soundIdSuccess =
        await rootBundle.load("sounds/success.mp3").then((ByteData soundData) {
      return poolAlarm.load(soundData);
    });

    this.soundIdError =
        await rootBundle.load("sounds/error.mp3").then((ByteData soundData) {
      return poolAlarm.load(soundData);
    });

    this.soundIdPage =
        await rootBundle.load("sounds/page.mp3").then((ByteData soundData) {
      return poolAlarm.load(soundData);
    });
  }

  _navigateBack() {
    _playPageSound();
    setState(() {
      this.idChapter -= 1;
    });
  }

  _navigateFoward() {
    _playPageSound();
    setState(() {
      this.idChapter += 1;
    });
  }

  _playPageSound() async {
    await poolAlarm.play(this.soundIdPage);
  }

  _navigateError() {}
}
