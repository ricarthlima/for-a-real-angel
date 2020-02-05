import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/helper/update_ranking.dart';
import 'package:for_a_real_angel/model/chapter.dart';
import 'package:for_a_real_angel/screens/chapter_splash.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/partials/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';

class SimpleCap extends StatefulWidget {
  SoundPlayer soundPlayer;
  SimpleCap({this.soundPlayer});
  @override
  _SimpleCapState createState() => _SimpleCapState();
}

class _SimpleCapState extends State<SimpleCap> {
  int idChapter = 0;
  int idLastUnlockedChapter = 0;

  // Controllers
  ScrollController _controllerScroll;
  TextEditingController _controllerCode = TextEditingController();

  List<Chapter> chapters = [
    Chapter(
      0,
      Icons.ac_unit,
      "",
      "",
      "",
      "-159-",
      "",
      Map<String, String>(),
    )
  ];

  //Hints Unlocked
  bool isUnlockedHint = false;

  //User Coins
  int userCoins;

  @override
  void initState() {
    idChapter = 0;
    _read();
    _controllerScroll = ScrollController();
    super.initState();

    _especialSounds();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Chapter cap = chapters[idChapter];

    return Scaffold(
      appBar: getMenuBar(
        context: context,
        icon: IconsValues.soul,
        title: (idChapter <= 1) ? "97 110 100 114 101 119" : "andrew",
        soundPlayer: widget.soundPlayer,
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
                          Icon(
                            (this.idChapter <= 5)
                                ? Icons.ac_unit
                                : (this.idChapter <= 10)
                                    ? Icons.leak_remove
                                    : Icons.radio_button_unchecked,
                          ),
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
                    cap.text.replaceAll("/n", "\n"),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                  ),
                  ((this.idChapter == this.idLastUnlockedChapter) &&
                          (this.chapters[this.idChapter].goodHint != "last"))
                      ? Container(
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
                                textAlign: TextAlign.center,
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
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _testCode(_controllerCode.text, context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey, width: 2),
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
                                  GestureDetector(
                                    onTap: () {
                                      _showHint(context);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Dica",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "CourierPrime",
                                              ),
                                            ),
                                            (!this.isUnlockedHint)
                                                ? Row(
                                                    children: <Widget>[
                                                      Text(" (10"),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 2),
                                                      ),
                                                      Image.asset(
                                                        IconsValues.data_points,
                                                        width: 15,
                                                        height: 15,
                                                      ),
                                                      Text(")"),
                                                    ],
                                                  )
                                                : Container()
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                          children: <Widget>[
                            Text(
                              chapters[idChapter].tipQuote,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                            ),
                            Text(
                              (this.chapters[this.idChapter].goodHint != "last")
                                  ? chapters[idChapter + 1].code
                                  : "",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
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
    final value = prefs.getInt(PreferencesKey.chapterId);

    //Chapter ID
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

    _readHints(prePrefs: prefs);
    _readCoins(prePrefs: prefs);

    // Read Chapter List
    _readChapterList(prefs);
  }

  _readChapterList(prefs) {
    // List to get chapters
    List<Chapter> tempList = new List<Chapter>();

    // Read from Shared Preferences
    var rawData = prefs.getString(PreferencesKey.chaptersList);

    // Decode a String
    Map<String, dynamic> jsonData = jsonDecode(rawData);
    for (var key in jsonData.keys) {
      Map<String, dynamic> data = jsonData[key];
      Chapter tempCap = Chapter.fromData(
        id: data["id"],
        icon: Icons.ac_unit,
        title: data["title"],
        text: data["text"],
        tipQuote: data["tipQuote"],
        code: data["code"],
        goodHint: data["goodHint"],
        closeTrys: data["closeTrys"],
      );
      tempList.add(tempCap);
    }

    // Sort list by ID
    tempList.sort((a, b) {
      return a.id.compareTo(b.id);
    });

    // Update real list chapters
    setState(() {
      this.chapters = tempList;
    });
  }

  Future _readHints({prePrefs = "null"}) async {
    var prefs = prePrefs;
    if (prePrefs == "null") {
      prefs = await SharedPreferences.getInstance();
    }
    final hints = prefs.getBool(PreferencesKey.isUnlockedHint);

    //Hints
    if (hints != null) {
      setState(() {
        this.isUnlockedHint = hints;
      });
    } else {
      setState(() {
        this.isUnlockedHint = false;
      });
      _saveHintsChange();
    }
  }

  Future _readCoins({prePrefs = "null"}) async {
    var prefs = prePrefs;
    if (prePrefs == "null") {
      prefs = await SharedPreferences.getInstance();
    }

    final coins = prefs.getInt(PreferencesKey.userCoins);

    if (coins != null) {
      setState(() {
        this.userCoins = coins;
      });
    } else {
      setState(() {
        this.userCoins = 0;
      });
      _saveUserCoins();
    }
  }

  Future _saveUserCoins() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.userCoins, this.userCoins);
    updateRanking();
  }

  _testCode(String value, BuildContext context) async {
    bool correct = false;
    int i = this.idChapter + 1;
    if (value.toLowerCase().replaceAll(" ", "") ==
        chapters[i].code.toLowerCase().replaceAll(" ", "")) {
      correct = true;
    }

    if (correct) {
      //Play Success SFX
      widget.soundPlayer.playSuccessSound();

      //Scroll screen to top
      _controllerScroll.jumpTo(0.0);

      //Hide keyboard
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      //Save unlocked stage
      _saveChapterId(chapters[i].id);

      //Change the screen
      setState(() {
        idChapter = chapters[i].id;
        idLastUnlockedChapter = chapters[i].id;
      });

      //Add Data Points
      setState(() {
        userCoins += 5;
      });
      _saveUserCoins();

      //Clear input area
      setState(() {
        _controllerCode.text = "";
      });

      //Lock next hint
      setState(() {
        isUnlockedHint = false;
      });
      _saveHintsChange();

      //If necessary play sound
      _especialSounds();

      //Show success dialog
      if (chapters[i].id % 5 == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChapterSplash(
                      soundPlayer: widget.soundPlayer,
                    )));
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
              content: Text("Restauração de memória: \n" +
                  (chapters[i].id * 2).toString() +
                  "% concluída.\n\nPontos de dados adicionados: 5"),
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
      if (chapters[this.idChapter]
          .closeTrys
          .keys
          .contains(value.toLowerCase())) {
        this.widget.soundPlayer.playCloseTrySound();
        String hint =
            chapters[this.idChapter].closeTrys[value.toLowerCase()].toString();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("ESTOU ME LEMBRANDO..."),
              titleTextStyle: TextStyle(
                  color: MyColors.topBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              contentTextStyle: TextStyle(color: Colors.black),
              content: Text(hint),
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
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text("ERRO!"),
                titleTextStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
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
        widget.soundPlayer.playErrorSound();
      }
      //Show fail dialog

    }
  }

  _saveChapterId(int chapterId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.chapterId, chapterId);
    updateRanking();
  }

  _saveHintsChange() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.isUnlockedHint, this.isUnlockedHint);
  }

  _navigateBack() {
    widget.soundPlayer.playPageSound();
    setState(() {
      this.idChapter -= 1;
    });
  }

  _navigateFoward() {
    widget.soundPlayer.playPageSound();
    setState(() {
      this.idChapter += 1;
    });
  }

  _navigateError() {}

  _showHint(BuildContext context) async {
    if (this.isUnlockedHint) {
      this.widget.soundPlayer.playGetHintSound();
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text(
                chapters[idChapter].goodHint,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );
    } else {
      if (this.userCoins >= 10) {
        this.widget.soundPlayer.playGetHintSound();
        setState(() {
          userCoins -= 10;
          this.isUnlockedHint = true;
        });
        _saveUserCoins();
        _saveHintsChange();
        _showHint(context);
      } else {
        //Play fail sound
        widget.soundPlayer.playErrorSound();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("ERRO"),
              content: Text(
                  "Não tenho pontos de dados suficientes para lhe ajudar!"),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
              contentTextStyle: TextStyle(color: Colors.black),
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
    }
  }

  _especialSounds() {
    //Play sound of Chapter 7
    if (this.idChapter == 7) {
      widget.soundPlayer.playMusic("files/message.mp3");
    }
  }
}
