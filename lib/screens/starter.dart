import 'package:flutter/material.dart';
import 'package:for_a_real_angel/desktop.dart';
import 'package:for_a_real_angel/screens/chapter_splash.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';

class Starter extends StatefulWidget {
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  bool _selectSkip = false;
  int nav = 0;

  @override
  void initState() {
    _read();
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
          Text("Como jogar F(or) A Real Angel?"),
          SwipeDetector(
            swipeConfiguration: SwipeConfiguration(
              horizontalSwipeMinVelocity: 50.0,
              horizontalSwipeMinDisplacement: 10.0,
            ),
            onSwipeLeft: () {
              if (nav < 3) {
                setState(() {
                  nav += 1;
                });
              }
            },
            onSwipeRight: () {
              if (nav > 0) {
                setState(() {
                  nav -= 1;
                });
              }
            },
            child: Column(
              children: <Widget>[
                (nav == 0)
                    ? Container(
                        height: 400,
                        child: Image.asset("assets/melhor.png"),
                      )
                    : (nav == 1)
                        ? Container(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/help2.png"),
                                Center(
                                  child: Text(
                                    "Acesse o sistema do PROJETO K22B para conseguir os Códigos de Restauração.",
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )
                        : (nav == 2)
                            ? Container(
                                height: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset("assets/dicas.png"),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Center(
                                      child: Text(
                                        "A cada capítulo, você receberá em laranja, uma dica crucial para a descoberta da chave que gera o código no sistema do PROJETO K22B.",
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                height: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset("assets/acerte.png"),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    Center(
                                      child: Text(
                                        "Quando você tiver o código, volte aqui e restaure o armazenamento para progredir na história.",
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: (nav == 0) ? Colors.white : Colors.grey,
                            width: 5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: (nav == 1) ? Colors.white : Colors.grey,
                            width: 5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: (nav == 2) ? Colors.white : Colors.grey,
                            width: 5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: (nav == 3) ? Colors.white : Colors.grey,
                            width: 5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    )
                  ],
                )
              ],
            ),
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
                  if (nav == 3) {
                    if (_selectSkip) {
                      _saveSkip();
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChapterSplash()));
                  }
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (nav == 3) ? Colors.white : Colors.black,
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                            color: (nav == 3) ? Colors.black : Colors.white),
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
          context, MaterialPageRoute(builder: (context) => ChapterSplash()));
    }
  }

  _saveSkip() async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.skipBasicInfos;
    final value = true;
    prefs.setBool(key, value);
  }
}
