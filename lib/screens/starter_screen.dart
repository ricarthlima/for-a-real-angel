import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/screens/chapter_splash.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Starter extends StatefulWidget {
  const Starter({Key? key}) : super(key: key);

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  bool? _selectSkip = false;

  @override
  void initState() {
    _read();
    _startTheMusic().then((value) {
      super.initState();
    });
    // _fazerPessoa();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(25),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.starterHints),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    pauseAutoPlayOnTouch: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                  ),
                  items: <Widget>[
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.sentiment_satisfied,
                          size: 75,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Text(
                          AppLocalizations.of(context)!.starterHintGiveUp,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.headset,
                          size: 75,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Text(
                          AppLocalizations.of(context)!.starterHintSounds,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.open_in_new,
                          size: 75,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Text(
                          AppLocalizations.of(context)!.starterHintInfos,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.public,
                          size: 75,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Text(
                          AppLocalizations.of(context)!.starterHintTools,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        const Icon(
                          Icons.comment,
                          size: 75,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Text(
                          AppLocalizations.of(context)!.starterHintCaps,
                          textAlign: TextAlign.center,
                        )
                      ],
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
                    onChanged: (bool? value) {
                      setState(() {
                        _selectSkip = value;
                      });
                    },
                  ),
                  Text(AppLocalizations.of(context)!.starterHintCheckbox),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (_selectSkip!) {
                    _saveSkip();
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChapterSplash()));
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.continuar,
                        style: const TextStyle(
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
    const key = PreferencesKey.skipBasicInfos;
    final value = prefs.getBool(key);

    if (value != null && value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChapterSplash(),
        ),
      );
    }
  }

  _saveSkip() async {
    final prefs = await SharedPreferences.getInstance();
    const key = PreferencesKey.skipBasicInfos;
    const value = true;
    prefs.setBool(key, value);
  }

  Future<void> _startTheMusic() async {
    final prefs = await SharedPreferences.getInstance();
    final isMusicOn = prefs.getBool(PreferencesKey.isMusicActive);

    if (isMusicOn != null) {
      if (isMusicOn) {
        context.read<SoundPlayer>().playBGM();
      }
    } else {
      prefs.setBool(PreferencesKey.isMusicActive, true);
      context.read<SoundPlayer>().playBGM();
    }
  }
}
