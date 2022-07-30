import 'package:flutter/material.dart';

class DesktopIcon extends StatelessWidget {
  final String icon;
  final String text;

  const DesktopIcon({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          icon,
          width: 45,
          height: 45,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 5),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontFamily: "CourierPrime",
            shadows: [
              Shadow(
                blurRadius: 1,
                color: Colors.black,
                offset: Offset(1, 1),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10),
        ),
      ],
    );
  }
}
