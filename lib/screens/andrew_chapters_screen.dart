import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/custom_dialog.dart';
import 'package:for_a_real_angel/helper/get_chapter_by_locale.dart';
import 'package:for_a_real_angel/helper/next_level_dialog.dart';
import 'package:for_a_real_angel/helper/save_firebase_internal_info.dart';
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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/sounds.dart';

class AndrewChaptersScreen extends StatefulWidget {
  const AndrewChaptersScreen({Key? key}) : super(key: key);

  @override
  State<AndrewChaptersScreen> createState() => _AndrewChaptersScreenState();
}

class _AndrewChaptersScreenState extends State<AndrewChaptersScreen> {
  // Info to navigation
  int idChapter = 0;
  int idLastUnlockedChapter = 0;

  // Controllers
  final ScrollController _controllerScroll = ScrollController();
  final TextEditingController _controllerCode = TextEditingController();

  List<AndrewChapter> listChapters = [];

  //Hints Unlocked
  //bool isUnlockedHint = false;
  int unlockedHints = 0;

  //User Coins
  late int userCoins;

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
      appBar: getAppBar(
        context: context,
        icon: IconsValues.soul,
        title: (idChapter <= 1) ? "97 110 100 114 101 119" : "andrew",
        isButtonShortcut: true,
        howShortcut: "andrew",
      ),
      body: (listChapters.isEmpty)
          ? Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: Text("${AppLocalizations.of(context)!.loading} ..."),
            )
          : GestureDetector(
              onPanUpdate: (details) {
                //Right
                if (details.delta.dx > 0) {
                  if (idChapter > 1) {
                    _navigateBack();
                  }
                }

                //Left
                if (details.delta.dx < 0) {
                  if (idChapter < idLastUnlockedChapter) {
                    _navigateFoward();
                  }
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SingleChildScrollView(
                    controller: _controllerScroll,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap:
                                  (idLastUnlockedChapter < 2 || idChapter < 2)
                                      ? () {
                                          _navigateError();
                                        }
                                      : () {
                                          _navigateBack();
                                        },
                              child: Icon(
                                Icons.navigate_before,
                                color:
                                    (idLastUnlockedChapter < 2 || idChapter < 2)
                                        ? Colors.grey
                                        : Colors.white,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Icon(
                                  (idChapter <= 5)
                                      ? Icons.ac_unit
                                      : (idChapter <= 10)
                                          ? Icons.leak_remove
                                          : Icons.radio_button_unchecked,
                                ),
                                Text(
                                    "${actualChapter.id} - ${actualChapter.title!}"),
                              ],
                            ),
                            GestureDetector(
                              onTap: (idChapter >= idLastUnlockedChapter)
                                  ? () {
                                      _navigateError();
                                    }
                                  : () {
                                      _navigateFoward();
                                    },
                              child: Icon(
                                Icons.navigate_next,
                                color: (idChapter >= idLastUnlockedChapter)
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(
                          actualChapter.text!.replaceAll("/n", "\n"),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.justify,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 35),
                        ),
                        ((idChapter == idLastUnlockedChapter) &&
                                (listChapters[idChapter].goodHint != "last"))
                            ? Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 3),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      actualChapter.tipQuote!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 12),
                                    ),
                                    TextField(
                                      controller: _controllerCode,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "CourierPrime",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _testCode(
                                            _controllerCode.text, context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .restore
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "CourierPrime",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        (unlockedHints < 3)
                                            ? GestureDetector(
                                                onTap: () {
                                                  _buyHint(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .buyHint,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "CourierPrime",
                                                        ),
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          const Text(" (10"),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 2),
                                                          ),
                                                          Image.asset(
                                                            IconsValues
                                                                .dataPoints,
                                                            width: 15,
                                                            height: 15,
                                                          ),
                                                          const Text(")"),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        (unlockedHints > 0 && unlockedHints < 3)
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                              )
                                            : Container(),
                                        (unlockedHints > 0)
                                            ? GestureDetector(
                                                onTap: () {
                                                  _showHint(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2),
                                                  ),
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .seeHints),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  Text(
                                    listChapters[idChapter].tipQuote!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  Text(
                                    (listChapters[idChapter].goodHint != "last")
                                        ? listChapters[idChapter + 1].code!
                                        : "",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
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
    final value = prefs.getInt(PreferencesKey.chapterId);

    //Chapter ID
    if (value != null) {
      setState(() {
        idChapter = value;
        idLastUnlockedChapter = value;
      });
    } else {
      setState(() {
        idChapter = 1;
        idLastUnlockedChapter = 1;
      });
    }

    _readHints(prePrefs: prefs);
    _readCoins(prePrefs: prefs);

    // Read Chapter List
    _readChapterList(prefs);
  }

  _readChapterList(prefs) async {
    // List to get chapters
    List<AndrewChapter> tempList = [];

    String chapters = await getChapterByLocale(context);

    Map jsonData = jsonDecode(chapters);

    for (var key in jsonData.keys) {
      Map<String, dynamic> data = jsonData[key];
      AndrewChapter tempCap = AndrewChapter.fromJson(data);
      tempList.add(tempCap);
    }

    // Sort list by ID
    tempList.sort((a, b) {
      return a.id!.compareTo(b.id!);
    });

    // Update real list chapters
    setState(() {
      listChapters = tempList;
    });
  }

  Future _readHints({prePrefs = "null"}) async {
    var prefs = prePrefs;
    if (prePrefs == "null") {
      prefs = await SharedPreferences.getInstance();
    }
    final hints = prefs.getInt(PreferencesKey.unlockedHints);

    //Hints
    if (hints != null) {
      setState(() {
        unlockedHints = hints;
      });
    } else {
      setState(() {
        unlockedHints = 0;
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
        userCoins = coins;
      });
    } else {
      setState(() {
        userCoins = 0;
      });
      _saveUserCoins();
    }
  }

  Future _saveUserCoins() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.userCoins, userCoins);
    updateRanking();
    saveFirebaseInternalInfo();
  }

  _testCode(String value, BuildContext context) async {
    bool correct = false;
    int i = idChapter + 1;
    if (value.toLowerCase().replaceAll(" ", "") ==
        listChapters[i].code!.toLowerCase().replaceAll(" ", "")) {
      correct = true;
    }

    if (correct) {
      //Play Success SFX
      context.read<SoundPlayer>().playSFX(Sounds.idSuccess);

      //Scroll screen to top
      _controllerScroll.jumpTo(0.0);

      //Hide keyboard
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      //Save unlocked stage
      _saveChapterId(listChapters[i].id!);

      //Change the screen
      setState(() {
        idChapter = listChapters[i].id!;
        idLastUnlockedChapter = listChapters[i].id!;
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
        unlockedHints = 0;
      });
      _saveHintsChange();

      //If necessary play sound
      _especialSounds();

      //Show success dialog
      if (listChapters[i].id! % 5 == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ChapterSplash()));
      } else {
        showNextLevelDialog(context, listChapters[i].id);
      }
    } else {
      if (listChapters[idChapter]
          .closeTrys!
          .keys
          .contains(value.toLowerCase())) {
        context.read<SoundPlayer>().playSFX(Sounds.idCloseTry);
        String hint =
            listChapters[idChapter].closeTrys![value.toLowerCase()].toString();
        showHintDialog(context, hint);
      } else {
        showErrorDialog(
          context: context,
          title: AppLocalizations.of(context)!.error,
          content: AppLocalizations.of(context)!.incorrectRestaurationCode,
        );
        //Play fail sound
        context.read<SoundPlayer>().playSFX(Sounds.idError);
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
    prefs.setInt(PreferencesKey.unlockedHints, unlockedHints);
  }

  _navigateBack() {
    context.read<SoundPlayer>().playSFX(Sounds.idPage);
    setState(() {
      idChapter -= 1;
    });
  }

  _navigateFoward() {
    context.read<SoundPlayer>().playSFX(Sounds.idPage);
    setState(() {
      idChapter += 1;
    });
  }

  _navigateError() {}

  String _getTextHints(AndrewChapter cap, int un) {
    String retorno = "";
    if (un > 0) {
      retorno += cap.badHint!;
      if (un > 1) {
        retorno = "$retorno\n\n-----------\n\n${cap.goodHint!}";
        if (un > 2) {
          retorno = "$retorno\n\n-----------\n\n${cap.niceHint!}";
        }
      }
    }
    return retorno;
  }

  _showHint(BuildContext context) async {
    if (unlockedHints > 0) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                _getTextHints(listChapters[idChapter], unlockedHints),
                style: const TextStyle(
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
      //Play fail sound
      context.read<SoundPlayer>().playSFX(Sounds.idError);
      showErrorDialog(
          context: context,
          title: AppLocalizations.of(context)!.error,
          content: AppLocalizations.of(context)!.noneHint);
    }
  }

  _buyHint(BuildContext context) {
    if (userCoins >= 10 && unlockedHints < 3) {
      context.read<SoundPlayer>().playSFX(Sounds.idGetHint);
      setState(() {
        userCoins -= 10;
        unlockedHints += 1;
      });
      _saveUserCoins();
      _saveHintsChange();
      _showHint(context);
    } else {
      //Play fail sound
      context.read<SoundPlayer>().playSFX(Sounds.idError);
      showErrorDialog(
          context: context,
          title: AppLocalizations.of(context)!.error,
          content: AppLocalizations.of(context)!.noDataPoints);
    }
  }

  _especialSounds() {
    //Play sound of Chapter 7
    if (idChapter == 7) {
      context.read<SoundPlayer>().playMusic("files/message.mp3");
    }
  }
}
