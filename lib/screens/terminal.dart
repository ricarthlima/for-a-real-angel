import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/helper/customDialog.dart';
import 'package:for_a_real_angel_demo/helper/launch_url.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/values/icons_values.dart';
import 'package:for_a_real_angel_demo/values/my_colors.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:for_a_real_angel_demo/partials/menu_bar.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Terminal extends StatefulWidget {
  SoundPlayer soundPlayer;
  Terminal({this.soundPlayer});
  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
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
          showMyCustomDialog(
              context: context,
              title: Text("Acesso negado!"),
              content: Text(
                  "O acesso ao ranking mundial está disponível apenas na versão completa."),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Deixa...",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text(
                    "Quero comprar!",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    launchURL(
                      "https://play.google.com/store/apps/details?id=com.ricarthlima.for_a_real_angel",
                    );
                  },
                ),
              ]);
        }
        break;
      default:
        {
          setState(() {
            log.add("'" +
                cmd +
                "' não foi reconhecido como um comando do terminal.\n");
          });
        }
    }
  }
}
