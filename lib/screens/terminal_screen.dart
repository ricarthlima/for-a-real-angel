import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/localizations.dart';
import 'package:for_a_real_angel_demo/screens/ranking_screen.dart';
import 'package:for_a_real_angel_demo/values/icons_values.dart';
import 'package:for_a_real_angel_demo/values/my_colors.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:for_a_real_angel_demo/partials/menu_bar.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TerminalScreen extends StatefulWidget {
  SoundPlayer soundPlayer;
  TerminalScreen({this.soundPlayer});
  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  TextEditingController _inputController = new TextEditingController();

  String version = "0.3.1";
  int idChapter = 1;

  List<String> log = [""];

  @override
  void initState() {
    _readVersion();
    _readChapter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getMenuBar(
        icon: IconsValues.console,
        title: "Terminal",
        context: context,
        soundPlayer: widget.soundPlayer,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: MyColors.topBlue,
            width: 7,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "PROJECT K22B [" +
                    this.version +
                    "]\n" +
                    "(org) 1962 USA-URSS EXCEPTION UNION\n" +
                    "Type 'help' to list the commands.\n",
                style: TextStyle(
                  fontFamily: "CourierPrime",
                ),
                textAlign: TextAlign.start,
              ),
              (this.idChapter == 4)
                  ? Text(
                      "venceu_enigma",
                      style: TextStyle(fontFamily: "CourierPrime"),
                    )
                  : Container(),
              for (var text in log)
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: "CourierPrime",
                  ),
                  textAlign: TextAlign.start,
                ),
              TextField(
                controller: _inputController,
                onSubmitted: (string) {
                  setState(() {
                    log.add(string);
                    _commandBatch(_inputController.text, context);
                    _inputController.text = "";
                  });
                },
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "CourierPrime",
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _readVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      this.version = packageInfo.version;
    });
  }

  Future _readChapter() async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.chapterId;
    final value = prefs.getInt(key);

    if (value != null) {
      setState(() {
        this.idChapter = value;
      });
    } else {
      setState(() {
        this.idChapter = 1;
      });
    }
  }

  _commandBatch(String cmd, BuildContext context) {
    switch (cmd) {
      case "help":
        {
          log.add("\nCommand List\n\n- 'ranking':\tShows the global ranking\n");
          break;
        }
      case "ranking":
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RankingScreen(soundPlayer: widget.soundPlayer)));
          break;
        }
      default:
        {
          setState(() {
            log.add("'" +
                cmd +
                "' " +
                AppLocalizations.of(context).notRecognizedCommand +
                "\n");
          });
        }
    }
  }
}
