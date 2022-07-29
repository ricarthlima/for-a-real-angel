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
          titlePadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          backgroundColor: MyColors.windowsGrey,
          title: Container(
            padding: EdgeInsets.all(5),
            color: MyColors.topBlue,
            child: Text(
              AppLocalizations.of(context)!.memoryRestored,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          contentTextStyle: TextStyle(color: Colors.black),
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
                    (id * 2).toString() + "%",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  linearStrokeCap: LinearStrokeCap.butt,
                  progressColor: Colors.blue,
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Text(
                  "+ 5 " + AppLocalizations.of(context)!.dataPoints,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColors.darkGreen,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 15),
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
                    child: Text(
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
