import 'package:flutter/material.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/values/my_colors.dart';

showHintDialog(BuildContext context, String hint) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.remebering + "..."),
        titleTextStyle: TextStyle(
            color: MyColors.topBlue, fontWeight: FontWeight.bold, fontSize: 18),
        contentTextStyle: TextStyle(color: Colors.black),
        content: Text(hint),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      );
    },
  );
}
