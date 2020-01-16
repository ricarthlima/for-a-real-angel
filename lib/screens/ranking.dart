import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/visual_objects/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  Firestore db = Firestore.instance;
  String username = "";
  bool logado = false;
  int coins = 0;
  int chapter_id = 0;

  TextEditingController _controllerCode = TextEditingController();

  @override
  void initState() {
    _checkAuth();
    _readInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getMenuBar(
        context: context,
        icon: IconsValues.console,
        title: "ranking",
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.topBlue, width: 5),
          color: Colors.black,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              (!logado) ? Text("Você ainda não se cadastrou.") : Container(),
              (!logado)
                  ? TextField(
                      controller: _controllerCode,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "CourierPrime",
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Container(
                      child: Text(username),
                    ),
              (!logado)
                  ? GestureDetector(
                      onTap: () {
                        _authenticateUser(context, _controllerCode.text);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getString(PreferencesKey.username);

    setState(() {
      if (current != null) {
        logado = true;
        username = current;
      } else {
        logado = false;
      }
    });
  }

  _readInfos() async {
    final prefs = await SharedPreferences.getInstance();
    final coins = prefs.getInt(PreferencesKey.userCoins);
    final capId = prefs.getInt(PreferencesKey.chapterId);

    setState(() {
      if (coins != null) {
        this.coins = coins;
      } else {
        this.coins = 0;
      }

      if (capId != null) {
        this.chapter_id = capId;
      } else {
        this.chapter_id = 1;
      }
    });
  }

  Future<String> _authenticateUser(BuildContext context, String name) async {
    // Make a query to check username
    QuerySnapshot query = await db
        .collection("users")
        .where("username", isEqualTo: name)
        .getDocuments();

    if (query.documents.length == 0) {
      final prefs = await SharedPreferences.getInstance();

      // Add to Firebase
      DocumentReference ref = await db.collection("users").add(
          {"username": name, "chapter": this.chapter_id, "coins": this.coins});

      // Save username and firebaseid
      prefs.setString(PreferencesKey.username, name);
      prefs.setString(PreferencesKey.firebaseIdUser, ref.documentID);

      // Update state
      setState(() {
        this.logado = true;
        this.username = name;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("ERRO!"),
              titleTextStyle: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
              contentTextStyle: TextStyle(color: Colors.black),
              content: Text("Nome de usuário em uso."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          });
    }
  }
}
