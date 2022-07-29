import 'package:flutter/material.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

showNextLevelDialog(BuildContext context, int? id) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: Border.all(color: MyColors.topBlue, width: 10),
          titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          backgroundColor: MyColors.windowsGrey,
          title: Container(
            padding: const EdgeInsets.all(5),
            color: MyColors.topBlue,
            child: Text(
              AppLocalizations.of(context)!.memoryRestored,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          contentTextStyle: const TextStyle(color: Colors.black),
          content: Container(
            color: MyColors.windowsGrey,
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LinearPercentIndicator(
                  lineHeight: 18,
                  animation: true,
                  animationDuration: 1250,
                  percent: id! / 50,
                  center: Text(
                    "${id * 2}%",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  barRadius: const Radius.circular(5),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Text(
                  "+ 5 ${AppLocalizations.of(context)!.dataPoints}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: MyColors.darkGreen,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 15),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    color: MyColors.windowsGrey,
                    child: const Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            )
          ]);
    },
  );
}
