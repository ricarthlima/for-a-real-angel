import 'package:for_a_real_angel/screens/desktop_screen.dart';
import 'package:for_a_real_angel/visual_objects/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class Desktop extends StatefulWidget {
  String wallpaper = "assets/wallpaper-def.png";
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
          SwipeDetector(
            onSwipeLeft: () {
              _inverterWallpaper();
            },
            onSwipeRight: () {
              _normalizarWallpaper();
            },
            child: Center(
              child: Image.asset(
                widget.wallpaper,
                height: size.height,
                fit: BoxFit.none,
              ),
            ),
          ),
          DesktopScreen(),
          TaskBar(),
        ],
      ),
    );
  }

  void _inverterWallpaper() {
    setState(() {
      widget.wallpaper = "assets/wallpaper-inv.png";
    });
  }

  void _normalizarWallpaper() {
    setState(() {
      widget.wallpaper = "assets/wallpaper-def.png";
    });
  }
}
