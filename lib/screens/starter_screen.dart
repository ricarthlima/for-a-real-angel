import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/localizations.dart';
import 'package:for_a_real_angel_demo/screens/chapter_splash.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarterScreen extends StatefulWidget {
  @override
  _StarterScreenState createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  SoundPlayer soundPlayer = SoundPlayer();
  bool _selectSkip = false;

  @override
  void initState() {
    _read();
    _startTheMusic();
    // _fazerPessoa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(25),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context).starterHints),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: CarouselSlider(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  items: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.sentiment_satisfied,
                            size: 75,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Text(
                            AppLocalizations.of(context).starterHintGiveUp,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.headset,
                            size: 75,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Text(
                            AppLocalizations.of(context).starterHintSounds,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.open_in_new,
                            size: 75,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Text(
                            AppLocalizations.of(context).starterHintInfos,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.public,
                            size: 75,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Text(
                            AppLocalizations.of(context).starterHintTools,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            size: 75,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Text(
                            AppLocalizations.of(context).starterHintCaps,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    value: _selectSkip,
                    onChanged: (bool value) {
                      setState(() {
                        _selectSkip = value;
                      });
                    },
                  ),
                  Text(AppLocalizations.of(context).starterHintCheckbox),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (_selectSkip) {
                    _saveSkip();
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChapterSplash(
                                soundPlayer: this.soundPlayer,
                              )));
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).continuar,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.skipBasicInfos;
    final value = prefs.getBool(key);

    if (value != null && value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChapterSplash(
            soundPlayer: this.soundPlayer,
          ),
        ),
      );
    }
  }

  _saveSkip() async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.skipBasicInfos;
    final value = true;
    prefs.setBool(key, value);
  }

  void _startTheMusic() async {
    final prefs = await SharedPreferences.getInstance();
    final isMusicOn = prefs.getBool(PreferencesKey.isMusicActive);

    if (isMusicOn != null) {
      if (isMusicOn) {
        soundPlayer.playBGM();
      }
    } else {
      prefs.setBool(PreferencesKey.isMusicActive, true);
      soundPlayer.playBGM();
    }
  }
}
