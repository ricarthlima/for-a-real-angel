import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/values/my_colors.dart';

AppBar getMenuBar({
  @required BuildContext context,
  @required title,
  @required icon,
  @required SoundPlayer soundPlayer,
}) {
  return AppBar(
    leading: Container(
      padding: EdgeInsets.all(10),
      child: Image.asset(
        icon,
        width: 20,
        height: 20,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
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
        icon: Icon(Icons.clear),
        onPressed: () {
          soundPlayer.playExitSound();
          Navigator.pop(context);
        },
      )
    ],
  );
}
