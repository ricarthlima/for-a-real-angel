import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/custom_dialog.dart';
import 'package:for_a_real_angel/helper/getAndrewChapterLocale.dart';
import 'package:for_a_real_angel/helper/next_level_dialog.dart';
import 'package:for_a_real_angel/helper/show_hint_dialog.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/helper/update_ranking.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/model/chapter.dart';
import 'package:for_a_real_angel/screens/chapter_splash.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/partials/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';

class AndrewChaptersScreen extends StatefulWidget {
  final SoundPlayer soundPlayer;
  AndrewChaptersScreen({this.soundPlayer});
  @override
  _AndrewChaptersScreenState createState() => _AndrewChaptersScreenState();
}

class _AndrewChaptersScreenState extends State<AndrewChaptersScreen> {
  // Info to navigation
  int idChapter = 0;
  int idLastUnlockedChapter = 0;

  // Controllers
  ScrollController _controllerScroll = ScrollController();
  TextEditingController _controllerCode = TextEditingController();

  List<AndrewChapter> listChapters = List<AndrewChapter>();

  //Hints Unlocked
  bool isUnlockedHint = false;

  //User Coins
  int userCoins;

  @override
  void initState() {
    _read();
    _especialSounds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AndrewChapter actualChapter = AndrewChapter();

    if (listChapters.isNotEmpty) {
      actualChapter = listChapters[idChapter];
    }

    return Scaffold(
      appBar: getMenuBar(
        context: context,
        icon: IconsValues.soul,
        title: (idChapter <= 1) ? "97 110 100 114 101 119" : "andrew",
        soundPlayer: widget.soundPlayer,
      ),
      body: (this.listChapters.isEmpty)
          ? Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context).loading + "..."),
            )
          : SwipeDetector(
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
                                Text(actualChapter.id.toString() +
                                    " - " +
                                    actualChapter.title),
                              ],
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.navigate_next,
                                color: (this.idChapter >=
                                        this.idLastUnlockedChapter)
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                              onTap:
                                  (this.idChapter >= this.idLastUnlockedChapter)
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
                          actualChapter.text.replaceAll("/n", "\n"),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.justify,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 35),
                        ),
                        ((this.idChapter == this.idLastUnlockedChapter) &&
                                (this.listChapters[this.idChapter].goodHint !=
                                    "last"))
                            ? Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 3),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      actualChapter.tipQuote,
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
                                            _testCode(
                                                _controllerCode.text, context);
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
                                              AppLocalizations.of(context)
                                                  .restore
                                                  .toUpperCase(),
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
                                                    color: Colors.grey,
                                                    width: 2),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .hint,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "CourierPrime",
                                                    ),
                                                  ),
                                                  (!this.isUnlockedHint)
                                                      ? Row(
                                                          children: <Widget>[
                                                            Text(" (10"),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 2),
                                                            ),
                                                            Image.asset(
                                                              IconsValues
                                                                  .data_points,
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
                                    listChapters[idChapter].tipQuote,
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
                                    (this
                                                .listChapters[this.idChapter]
                                                .goodHint !=
                                            "last")
                                        ? listChapters[idChapter + 1].code
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

  _readChapterList(prefs) async {
    // List to get chapters
    List<AndrewChapter> tempList = new List<AndrewChapter>();

    String chapters = await getAndrewChapterLocale(context);

    Map jsonData = jsonDecode(chapters);

    for (var key in jsonData.keys) {
      Map<String, dynamic> data = jsonData[key];
      AndrewChapter tempCap = AndrewChapter.fromJson(data);
      tempList.add(tempCap);
    }

    // Sort list by ID
    tempList.sort((a, b) {
      return a.id.compareTo(b.id);
    });

    // Update real list chapters
    setState(() {
      this.listChapters = tempList;
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
        listChapters[i].code.toLowerCase().replaceAll(" ", "")) {
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
      _saveChapterId(listChapters[i].id);

      //Change the screen
      setState(() {
        idChapter = listChapters[i].id;
        idLastUnlockedChapter = listChapters[i].id;
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
      if (listChapters[i].id % 5 == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChapterSplash(
                      soundPlayer: widget.soundPlayer,
                    )));
      } else {
        showNextLevelDialog(context, listChapters[i].id);
      }
    } else {
      if (listChapters[this.idChapter]
          .closeTrys
          .keys
          .contains(value.toLowerCase())) {
        this.widget.soundPlayer.playCloseTrySound();
        String hint = listChapters[this.idChapter]
            .closeTrys[value.toLowerCase()]
            .toString();
        showHintDialog(context, hint);
      } else {
        showErrorDialog(
          context: context,
          title: AppLocalizations.of(context).error,
          content: AppLocalizations.of(context).incorrectRestaurationCode,
        );
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
                listChapters[idChapter].goodHint,
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
        showErrorDialog(
            context: context,
            title: AppLocalizations.of(context).error,
            content: AppLocalizations.of(context).noDataPoints);
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
