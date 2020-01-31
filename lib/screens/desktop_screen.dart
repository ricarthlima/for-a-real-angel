import 'package:firebase_admob/firebase_admob.dart';
import 'package:for_a_real_angel_demo/helper/customDialog.dart';
import 'package:for_a_real_angel_demo/helper/launch_url.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/screens/explorer.dart';
import 'package:for_a_real_angel_demo/screens/simple_cap.dart';
import 'package:for_a_real_angel_demo/screens/terminal.dart';
import 'package:for_a_real_angel_demo/values/ad_values.dart';
import 'package:for_a_real_angel_demo/values/directories.dart';
import 'package:for_a_real_angel_demo/values/icons_values.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:for_a_real_angel_demo/partials/desktop_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopScreen extends StatefulWidget {
  SoundPlayer soundPlayer;
  DesktopScreen({this.soundPlayer});
  @override
  _DesktopScreenState createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  int dataPoints = 0;
  int chapterId = 1;

  @override
  void initState() {
    this.dataPoints = 0;
    this.chapterId = 1;
    _readChapterId();
    _readPreferences();
    super.initState();

    RewardedVideoAd.instance.load(
      adUnitId: AdValues.premiado,
      targetingInfo: AdValues.targetingInfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    _readPreferences();
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {},
        child: Table(
          children: [
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Explorer(
                        folder: Directories.recycleBin,
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.recycle_bin_empty,
                  text: "Recycle \nBin",
                ),
              ),
              Container(),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  showMyCustomDialog(
                    context: context,
                    title: Text("Data Points"),
                    content: Text(
                      "Você tem " +
                          this.dataPoints.toString() +
                          " Data Points\n\n" +
                          "Data Points são setores recuperados após uma desfragmentação. Você pode usar DPs para facilitar o processo de restauração dos dados. Eles também contam para seu ranking.",
                      textAlign: TextAlign.justify,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          RewardedVideoAd.instance
                              .show()
                              .then((e) {})
                              .catchError((onError) {
                            showMyCustomDialog(
                                context: context,
                                title: Text("ERRO!"),
                                content: Text(
                                    "Você ainda não possui anúncios disponíveis."),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "OK",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ]);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ganhe 5 DP de graça!",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  );
                },
                child: DesktopIcon(
                    icon: IconsValues.data_points,
                    text: this.dataPoints.toString() + "\nData Points"),
              ),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimpleCap(
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.soul,
                  text: (chapterId <= 1) ? "97 110 100 114 101 119" : "andrew",
                ),
              ),
              Container(),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  showMyCustomDialog(
                      context: context,
                      title: Text("Beta Disclaimer"),
                      content: Text(
                        "Se você está vendo esse aviso, você está jogando uma versão beta de FARA. " +
                            "Como o jogo está em construção você pode se deparar com erros ou bugs. " +
                            "Esses podem influenciar na sua experiência.\n\n" +
                            "Se achar algo de errado, me avisa: ricarth1@gmail.com.",
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ]);
                },
                child: DesktopIcon(
                  icon: IconsValues.warning,
                  text: "Beta Disclaimer",
                ),
              ),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Explorer(
                        folder: Directories.documents,
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.directory_closed,
                  text: "Documents",
                ),
              ),
              Container(),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  showMyCustomDialog(
                      context: context,
                      title: Text("Compre FARA!"),
                      content: Text(
                        "Chegou no nível 10? Compre a versão completa de FARA para ter acesso a continuação dessa história.\nBenefícios:\n" +
                            "\n- Sem anúncios." +
                            "\n- Novos níveis chegam semanalmente." +
                            "\n- Correção em tempo real de erros e bugs." +
                            "\n- Participação no ranking mundial.",
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Quero comprar!",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () {
                            launchURL(
                              "https://play.google.com/store/apps/details?id=com.ricarthlima.for_a_real_angel",
                            );
                          },
                        ),
                      ]);
                },
                child: DesktopIcon(
                  icon: IconsValues.fara,
                  text: "Compre FARA!",
                ),
              ),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Terminal(
                                soundPlayer: widget.soundPlayer,
                              )));
                },
                child: DesktopIcon(
                  icon: IconsValues.console,
                  text: "Terminal",
                ),
              ),
              Container(),
              Container(),
              Container(),
              Container(),
            ]),
          ],
        ),
      ),
    );
  }

  Future _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final coins = prefs.getInt(PreferencesKey.userCoins);

    if (coins != null) {
      setState(() {
        this.dataPoints = coins;
      });
    } else {
      setState(() {
        this.dataPoints = 0;
      });
      prefs.setInt(PreferencesKey.userCoins, 0);
    }
  }

  _readChapterId() async {
    final prefs = await SharedPreferences.getInstance();
    final capId = prefs.getInt(PreferencesKey.chapterId);

    if (capId != null) {
      setState(() {
        this.chapterId = capId;
      });
    } else {
      setState(() {
        this.chapterId = 1;
      });
    }
  }
}
