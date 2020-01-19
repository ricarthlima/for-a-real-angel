import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/screens/chapter_splash.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Starter extends StatefulWidget {
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  SoundPlayer soundPlayer = SoundPlayer();
  bool _selectSkip = false;

  @override
  void initState() {
    _read();
    soundPlayer.playBGM();
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
          Text("Dicas sobre F(or) A Real Angel"),
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
                            "Se você desiste fácil, FARA não é um jogo para você.",
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
                            "Os sons são importantes em FARA. Se possível, jogue com fones de ouvido.",
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
                            "Você está lidando com arquivos e informações secretas, sigilosas e criptografadas. Nada é o que parece, use todas as ferramentas para manipular os arquivos investigados.",
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
                            "Use todas as informações possíveis para resolver os enigmas. Não hesite em pesquisar e aprender sobre algum assunto novo.",
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
                            "As respostas devem sempre ser dadas na sua língua. Não se preocupe com acentos, caracteres especiais, espaços ou letras maiúsculas.",
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
                  Text("Entendi, não mostrar novamente."),
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
                        "Continuar",
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
}
