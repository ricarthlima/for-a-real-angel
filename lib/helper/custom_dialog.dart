import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/values/my_colors.dart';

showMyCustomDialog({
  BuildContext context,
  Widget title,
  Widget content,
  List<Widget> actions,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: MyColors.topBlue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          title: title,
          contentTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          content: content,
          actions: actions,
        );
      });
}

showErrorDialog({BuildContext context, String title, String content}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          titleTextStyle: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
          contentTextStyle: TextStyle(color: Colors.black),
          content: Text(content),
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
      });
}
