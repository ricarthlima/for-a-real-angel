import 'package:for_a_real_angel/screens/desktop_screen.dart';
import 'package:for_a_real_angel/visual_objects/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class Desktop extends StatefulWidget {
  @override
  _DesktopState createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  String wallpaper = "assets/wallpaper-def.png";
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
                this.wallpaper,
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
      this.wallpaper = "assets/wallpaper-inv.png";
    });
  }

  void _normalizarWallpaper() {
    setState(() {
      this.wallpaper = "assets/wallpaper-def.png";
    });
  }
}
