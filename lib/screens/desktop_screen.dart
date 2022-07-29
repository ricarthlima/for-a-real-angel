import 'package:for_a_real_angel/helper/custom_dialog.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/screens/andrew_chapters_screen.dart';
import 'package:for_a_real_angel/screens/explorer_screen.dart';
import 'package:for_a_real_angel/screens/terminal_screen.dart';
import 'package:for_a_real_angel/values/directories.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/partials/desktop_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/sounds.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({Key? key}) : super(key: key);

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  int dataPoints = 0;
  int chapterId = 1;
  bool isShowGiveCoinDialog = false;

  @override
  void initState() {
    dataPoints = 0;
    chapterId = 1;
    _readChapterId();
    _giveCoinsVerification();
    _readPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readPreferences();
    return Container(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {},
        child: Table(
          children: [
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  context.read<SoundPlayer>().playSFX(Sounds.idClick);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Explorer(
                        folder: Directories.recycleBin,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.recycleBinEmpty,
                  text: AppLocalizations.of(context)!.recycleBin,
                ),
              ),
              Container(),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  context.read<SoundPlayer>().playSFX(Sounds.idClick);
                  showMyCustomDialog(
                      context: context,
                      title: Text(
                        AppLocalizations.of(context)!.dataPoints,
                      ),
                      content: Text(
                        "${AppLocalizations.of(context)!.youHave} $dataPoints ${AppLocalizations.of(context)!.dataPoints}.\n\n${AppLocalizations.of(context)!.dataPointsExplanation}",
                        textAlign: TextAlign.justify,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.okay,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ]);
                },
                child: DesktopIcon(
                    icon: IconsValues.dataPoints,
                    text:
                        "$dataPoints\n${AppLocalizations.of(context)!.dataPoints}"),
              ),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  context.read<SoundPlayer>().playSFX(Sounds.idClick);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AndrewChaptersScreen(),
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
              Container(),
              // GestureDetector(
              //   onTap: () {
              //     context.read<SoundPlayer>().playSFX(Sounds.idClick);
              //     showMyCustomDialog(
              //         context: context,
              //         title: Text(AppLocalizations.of(context)!.betaDisclaimer),
              //         content: Text(
              //           AppLocalizations.of(context)!.betaDisclaimerText,
              //           textAlign: TextAlign.justify,
              //         ),
              //         actions: <Widget>[
              //           FlatButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //             },
              //             child: Text(
              //               AppLocalizations.of(context)!.okay,
              //               style: const TextStyle(
              //                 color: Colors.grey,
              //               ),
              //             ),
              //           )
              //         ]);
              //   },
              //   child: DesktopIcon(
              //     icon: IconsValues.warning,
              //     text: AppLocalizations.of(context)!.betaDisclaimer,
              //   ),
              // ),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  context.read<SoundPlayer>().playSFX(Sounds.idClick);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Explorer(
                        folder: Directories.documents,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.directoryClosed,
                  text: AppLocalizations.of(context)!.documents,
                ),
              ),
              Container(),
              Container(),
              Container(),
              Container(),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  context.read<SoundPlayer>().playSFX(Sounds.idClick);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Terminal()));
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
        dataPoints = coins;
      });
    } else {
      setState(() {
        dataPoints = 0;
      });
      prefs.setInt(PreferencesKey.userCoins, 0);
    }
  }

  _readChapterId() async {
    final prefs = await SharedPreferences.getInstance();
    final capId = prefs.getInt(PreferencesKey.chapterId);

    if (capId != null) {
      setState(() {
        chapterId = capId;
      });
    } else {
      setState(() {
        chapterId = 1;
      });
    }
  }

  _giveCoinsVerification() async {
    final prefs = await SharedPreferences.getInstance();
    final giveCoins = prefs.getBool(PreferencesKey.giveCoins);

    // Dar as 100 moedas
    if (giveCoins == null) {
      prefs.setInt(PreferencesKey.userCoins, 100);
      prefs.setBool(PreferencesKey.giveCoins, false);
      setState(
        () {
          dataPoints = 100;
        },
      );
    }
  }
}
