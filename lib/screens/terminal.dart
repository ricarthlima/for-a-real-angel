import 'package:flutter/material.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/visual_objects/menu_bar.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Terminal extends StatefulWidget {
  String version = "0.3.1";
  int idChapter = 1;

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
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
          icon: IconsValues.console, title: "Terminal", context: context),
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
                    widget.version +
                    "]\n" +
                    "(org) 1962 USA-URSS EXCEPTION UNION\n",
                style: TextStyle(
                  fontFamily: "CourierPrime",
                ),
                textAlign: TextAlign.start,
              ),
              (widget.idChapter == 4)
                  ? Text(
                      "venceu_enigma",
                      style: TextStyle(fontFamily: "CourierPrime"),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _readVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      widget.version = packageInfo.version;
    });
  }

  Future _readChapter() async {
    final prefs = await SharedPreferences.getInstance();
    final key = PreferencesKey.chapterId;
    final value = prefs.getInt(key);

    if (value != null) {
      setState(() {
        widget.idChapter = value;
      });
    } else {
      setState(() {
        widget.idChapter = 1;
      });
    }
  }
}
