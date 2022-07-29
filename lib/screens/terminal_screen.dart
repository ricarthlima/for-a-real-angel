import 'package:flutter/material.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/screens/ranking_screen.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/partials/menu_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Terminal extends StatefulWidget {
  const Terminal({Key? key}) : super(key: key);

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  final TextEditingController _inputController = TextEditingController();

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
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
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
                "PROJECT K22B [$version]\n(org) 1962 USA-URSS EXCEPTION UNION\nType 'help' to list the commands.\n",
                style: const TextStyle(
                  fontFamily: "CourierPrime",
                ),
                textAlign: TextAlign.start,
              ),
              (idChapter == 4)
                  ? const Text(
                      "venceu_enigma",
                      style: TextStyle(fontFamily: "CourierPrime"),
                    )
                  : Container(),
              for (var text in log)
                Text(
                  text,
                  style: const TextStyle(
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
                style: const TextStyle(
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
      version = packageInfo.version;
    });
  }

  Future _readChapter() async {
    final prefs = await SharedPreferences.getInstance();
    const key = PreferencesKey.chapterId;
    final value = prefs.getInt(key);

    if (value != null) {
      setState(() {
        idChapter = value;
      });
    } else {
      setState(() {
        idChapter = 1;
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RankingScreen()));
          break;
        }
      default:
        {
          setState(() {
            log.add(
                "'$cmd' ${AppLocalizations.of(context)!.notRecognizedCommand}\n");
          });
        }
    }
  }
}
