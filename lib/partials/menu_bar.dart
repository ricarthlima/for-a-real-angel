import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:provider/provider.dart';

import '../values/sounds.dart';

AppBar getAppBar({
  required BuildContext context,
  required title,
  required icon,
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
