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
  bool isActivatedShortcut = false;

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
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            //(0,0) - Lixeixa
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

            //(0,1)
            Container(),

            //(0,2)
            Container(),

            //(0,3) - Pontos de dados
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
                      TextButton(
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

            //(1,0) - Terminal
            GestureDetector(
              onTap: () {
                context.read<SoundPlayer>().playSFX(Sounds.idClick);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Terminal()));
              },
              child: const DesktopIcon(
                icon: IconsValues.console,
                text: "Terminal",
              ),
            ),

            //(1,1)
            Container(),

            //(1,2)
            Container(),

            //(1,3)
            Container(),

            //(2,0) - Documentos
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

            //(2,1)
            Container(),

            //(2,2)
            Container(),

            //(2,3)
            Container(),

            //(3,0) - Andrew
            (isActivatedShortcut)
                ? GestureDetector(
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
                      text: (chapterId <= 1)
                          ? "97 110 100 114 101 119"
                          : "andrew",
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final coins = prefs.getInt(PreferencesKey.userCoins);
    final shortcut = prefs.getBool(PreferencesKey.isEnableShortcutAndrew);

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

    if (shortcut != null) {
      setState(() {
        isActivatedShortcut = shortcut;
      });
    } else {
      prefs.setBool(PreferencesKey.isEnableShortcutAndrew, false);
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
