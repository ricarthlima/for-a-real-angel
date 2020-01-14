import 'package:for_a_real_angel/screens/explorer.dart';
import 'package:for_a_real_angel/screens/simple_cap.dart';
import 'package:for_a_real_angel/screens/terminal.dart';
import 'package:for_a_real_angel/values/directories.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/visual_objects/desktop_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopScreen extends StatefulWidget {
  int data_points = 0;
  @override
  _DesktopScreenState createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  @override
  void initState() {
    widget.data_points = 0;
    _readPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readPreferences();
    return Container(
      padding: EdgeInsets.all(10),
      child: Table(
        children: [
          TableRow(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Explorer(
                      folder: Directories.recycleBin,
                    ),
                  ),
                );
              },
              child: DesktopIcon(
                IconsValues.recycle_bin_empty,
                "Recycle \nBin",
              ),
            ),
            Container(),
            Container(),
            Container(),
            Container(
              child: DesktopIcon(IconsValues.data_points,
                  widget.data_points.toString() + "\nData Points"),
            ),
          ]),
          TableRow(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SimpleCap()));
              },
              child: DesktopIcon(
                IconsValues.agent,
                "Andrew",
              ),
            ),
            Container(),
            Container(),
            Container(),
            Container(),
          ]),
          TableRow(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Explorer(
                      folder: Directories.documents,
                    ),
                  ),
                );
              },
              child: DesktopIcon(
                IconsValues.directory_closed,
                "Documents",
              ),
            ),
            Container(),
            Container(),
            Container(),
            Container(),
          ]),
          TableRow(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Terminal()));
              },
              child: DesktopIcon(IconsValues.console, "Terminal"),
            ),
            Container(),
            Container(),
            Container(),
            Container(),
          ]),
        ],
      ),
    );
  }

  Future _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.userCoins;
    final value = prefs.getInt(key);

    setState(() {
      widget.data_points = value;
    });
  }
}
