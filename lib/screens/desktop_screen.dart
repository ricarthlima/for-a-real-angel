import 'package:for_a_real_angel/screens/chapter_splash.dart';
import 'package:for_a_real_angel/screens/simple_cap.dart';
import 'package:for_a_real_angel/values/enum_icons.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/visual_objects/icons.dart';

class DesktopScreen extends StatefulWidget {
  @override
  _DesktopScreenState createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // LIXEIRA
              DesktopIcon(
                IconsValues.recycle_bin_empty,
                "Recycle Bin",
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SimpleCap()));
                },
                child: DesktopIcon(
                  IconsValues.fara,
                  "FARA",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
