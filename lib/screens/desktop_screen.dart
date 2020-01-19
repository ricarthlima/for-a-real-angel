import 'package:for_a_real_angel/helper/sound_player.dart';
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
  SoundPlayer soundPlayer;
  DesktopScreen({this.soundPlayer});
  @override
  _DesktopScreenState createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  int dataPoints = 0;
  int chapterId = 1;

  @override
  void initState() {
    this.dataPoints = 0;
    this.chapterId = 1;
    _readChapterId();
    _readPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readPreferences();
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {},
        child: Table(
          children: [
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Explorer(
                        folder: Directories.recycleBin,
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.recycle_bin_empty,
                  text: "Recycle \nBin",
                ),
              ),
              Container(),
              Container(),
              Container(),
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Data Points",
                            style: TextStyle(color: Colors.yellow),
                          ),
                          content: Text(
                            "Você tem " +
                                this.dataPoints.toString() +
                                " Data Points\n\n" +
                                "Data Points são setores recuperados após uma desfragmentação. Você pode usar DPs para facilitar o processo de restauração dos dados. Eles também contam para seu ranking.",
                            textAlign: TextAlign.justify,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            )
                          ],
                        );
                      });
                },
                child: DesktopIcon(
                    icon: IconsValues.data_points,
                    text: this.dataPoints.toString() + "\nData Points"),
              ),
            ]),
            TableRow(children: [
              GestureDetector(
                onTap: () {
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimpleCap(
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.soul,
                  text: (chapterId <= 1) ? "97 110 100 114 101 119" : "andrew",
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
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Explorer(
                        folder: Directories.documents,
                        soundPlayer: widget.soundPlayer,
                      ),
                    ),
                  );
                },
                child: DesktopIcon(
                  icon: IconsValues.directory_closed,
                  text: "Documents",
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
                  widget.soundPlayer.playClickSound();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Terminal(
                                soundPlayer: widget.soundPlayer,
                              )));
                },
                child: DesktopIcon(
                  icon: IconsValues.console,
                  text: "Terminal",
                ),
              ),
              Container(),
              Container(),
              Container(),
              Container(),
            ]),
          ],
        ),
      ),
    );
  }

  Future _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final coins = prefs.getInt(PreferencesKey.userCoins);

    if (coins != null) {
      setState(() {
        this.dataPoints = coins;
      });
    } else {
      setState(() {
        this.dataPoints = 0;
      });
      prefs.setInt(PreferencesKey.userCoins, 0);
    }
  }

  _readChapterId() async {
    final prefs = await SharedPreferences.getInstance();
    final capId = prefs.getInt(PreferencesKey.chapterId);

    if (capId != null) {
      setState(() {
        this.chapterId = capId;
      });
    } else {
      setState(() {
        this.chapterId = 1;
      });
    }
  }
}
