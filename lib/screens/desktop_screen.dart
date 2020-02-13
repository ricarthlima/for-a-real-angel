import 'package:firebase_admob/firebase_admob.dart';
import 'package:for_a_real_angel_demo/helper/custom_dialog.dart';
import 'package:for_a_real_angel_demo/localizations.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:for_a_real_angel_demo/helper/launch_url.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/screens/explorer_screen.dart';
import 'package:for_a_real_angel_demo/screens/andrew_chapters_screen.dart';
import 'package:for_a_real_angel_demo/screens/terminal_screen.dart';
import 'package:for_a_real_angel_demo/values/ad_values.dart';
import 'package:for_a_real_angel_demo/values/directories.dart';
import 'package:for_a_real_angel_demo/values/icons_values.dart';
import 'package:flutter/material.dart';
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
  bool isShowGiveCoinDialog = false;

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
                      builder: (context) => ExplorerScreen(
                        folder: Directories.recycleBin,
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.recycle_bin_empty,
                  text: AppLocalizations.of(context).recycleBin,
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
                      title: Text(
                        AppLocalizations.of(context).dataPoints,
                      ),
                      content: Text(
                        AppLocalizations.of(context).youHave +
                            " " +
                            this.dataPoints.toString() +
                            " " +
                            AppLocalizations.of(context).dataPoints +
                            ".\n\n" +
                            AppLocalizations.of(context).dataPointsExplanation,
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            RewardedVideoAd.instance.show().then((e) {
                              _giveFiveDP(context);
                            }).catchError((onError) {
                              showErrorDialog(
                                context: context,
                                title: AppLocalizations.of(context).error,
                                content:
                                    AppLocalizations.of(context).noAdsAvalible,
                              );
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context).getFiveDP,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ]);
                },
                child: DesktopIcon(
                    icon: IconsValues.data_points,
                    text: this.dataPoints.toString() +
                        "\n" +
                        AppLocalizations.of(context).dataPoints),
              ),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AndrewChaptersScreen(
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
                      title: Text(AppLocalizations.of(context).betaDisclaimer),
                      content: Text(
                        AppLocalizations.of(context).betaDisclaimerText,
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context).okay,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ]);
                },
                child: DesktopIcon(
                  icon: IconsValues.warning,
                  text: AppLocalizations.of(context).betaDisclaimer,
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
                      builder: (context) => ExplorerScreen(
                        folder: Directories.documents,
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.directory_closed,
                  text: AppLocalizations.of(context).documents,
                ),
              ),
              Container(),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  showMyCustomDialog(
                      context: context,
                      title: Text(AppLocalizations.of(context).buyFARA),
                      content: Text(
                        AppLocalizations.of(context).buyFARAText,
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            AppLocalizations.of(context).purchase,
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
                  text: AppLocalizations.of(context).buyFARA,
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
                          builder: (context) => TerminalScreen(
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

  void _giveFiveDP(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.userCoins, this.dataPoints + 5);

    showMyCustomDialog(
        context: context,
        title: Text("Aqui está!"),
        content: Text("Consegui recuperar 5DPs para você como prometido."),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Obrigado",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ]);
  }
}
