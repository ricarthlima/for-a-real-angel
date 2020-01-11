import 'package:flutter/material.dart';
import 'package:for_a_real_angel/values/enum_icons.dart';
import 'package:for_a_real_angel/values/my_colors.dart';

AppBar getMenuBar(
    {@required BuildContext context, @required title, @required icon}) {
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
        fontFamily: "PTSerif",
      ),
    ),
    centerTitle: true,
    backgroundColor: MyColors.topBlue,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
}
