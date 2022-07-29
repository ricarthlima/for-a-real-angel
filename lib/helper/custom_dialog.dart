import 'package:flutter/material.dart';
import 'package:for_a_real_angel/values/my_colors.dart';

showMyCustomDialog({
  required BuildContext context,
  Widget? title,
  Widget? content,
  List<Widget>? actions,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: MyColors.topBlue,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          title: title,
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          content: content,
          actions: actions,
        );
      });
}

showErrorDialog(
    {required BuildContext context, String? title, String? content}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title!),
        titleTextStyle: const TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
        contentTextStyle: const TextStyle(color: Colors.black),
        content: Text(content!),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      );
    },
  );
}
