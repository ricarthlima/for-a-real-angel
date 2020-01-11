import 'package:flutter/material.dart';

class DesktopIcon extends StatelessWidget {
  String icon;
  String text;

  DesktopIcon(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          this.icon,
          width: 45,
          height: 45,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
        ),
        Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontFamily: "PTSerif",
            shadows: [
              Shadow(
                blurRadius: 1,
                color: Colors.black,
                offset: Offset(1, 1),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
      ],
    );
  }
}
