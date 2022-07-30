import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/sounds.dart';

AppBar getAppBar({
  required BuildContext context,
  required title,
  required icon,
  bool? isButtonShortcut,
  String? howShortcut,
}) {
  return AppBar(
    leading: Container(
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        icon,
        width: 20,
        height: 20,
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontFamily: "CourierPrime",
        letterSpacing: -2,
        wordSpacing: -3,
      ),
    ),
    centerTitle: true,
    backgroundColor: MyColors.topBlue,
    actions: <Widget>[
      (isButtonShortcut != null && isButtonShortcut)
          ? IconButton(
              onPressed: () {
                enableShortcut(context, howShortcut);
              },
              icon: const Icon(Icons.shortcut))
          : Container(),
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          context.read<SoundPlayer>().playSFX(Sounds.idExit);
          Navigator.pop(context);
        },
      )
    ],
  );
}

enableShortcut(BuildContext context, String? howShortcut) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (howShortcut != null) {
    if (howShortcut == "andrew") {
      prefs.setBool(PreferencesKey.isEnableShortcutAndrew, true);
      context.read<SoundPlayer>().playSFX(Sounds.idGetHint);
    }
  }
}
