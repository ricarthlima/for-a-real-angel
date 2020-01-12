import 'package:for_a_real_angel/screens/explorer.dart';
import 'package:for_a_real_angel/screens/simple_cap.dart';
import 'package:for_a_real_angel/screens/terminal.dart';
import 'package:for_a_real_angel/values/directories.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/visual_objects/desktop_icons.dart';

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
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Terminal()));
                },
                child: DesktopIcon(IconsValues.console, "Terminal"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
