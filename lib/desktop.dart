import 'package:for_a_real_angel/screens/desktop_screen.dart';
import 'package:for_a_real_angel/visual_objects/taskbar.dart';
import 'package:flutter/material.dart';

class Desktop extends StatefulWidget {
  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/wallpaper.jpg",
              height: size.height,
              fit: BoxFit.none,
            ),
          ),
          DesktopScreen(),
          TaskBar(),
        ],
      ),
    );
  }
}
