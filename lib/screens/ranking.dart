import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/ranking.dart';
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
  int chapterId = 0;

  TextEditingController _controllerCode = TextEditingController();

  List<Ranking> listRanking = [
    Ranking(pos: 0, username: "andrew", chapter: 999, coins: 999)
  ];

  Ranking userRanking = Ranking(pos: 0, username: "", chapter: 0, coins: 0);

  @override
  void initState() {
    _checkAuth();
    _readInfos();
    _updateRanking();
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
              (logado)
                  ? Table(
                      children: [
                        TableRow(children: [
                          Text(
                            "POS",
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "USERNAME",
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "CHAPTER",
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "COINS",
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                        TableRow(
                          children: <Widget>[
                            Text(
                              this.userRanking.pos.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              this.userRanking.username,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              this.userRanking.chapter.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              this.userRanking.coins.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(),
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
                  : Container(),
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
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Divider(
                color: Colors.white,
                thickness: 2.0,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Text(
                "WORLD RANKING",
                style: TextStyle(color: Colors.yellow),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Table(
                children: [
                  TableRow(children: [
                    Text(
                      "POS",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "USERNAME",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "CHAPTER",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "COINS",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ]),
                  for (var rank in this.listRanking)
                    TableRow(children: [
                      Text(
                        rank.pos.toString(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        rank.username,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        rank.chapter.toString(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        rank.coins.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                ],
              ),
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
        this.chapterId = capId;
      } else {
        this.chapterId = 1;
      }
    });
  }

  _authenticateUser(BuildContext context, String name) async {
    // Make a query to check username
    QuerySnapshot query = await db
        .collection("users")
        .where("username", isEqualTo: name)
        .getDocuments();

    if (query.documents.length == 0) {
      final prefs = await SharedPreferences.getInstance();

      // Add to Firebase
      DocumentReference ref = await db.collection("users").add(
          {"username": name, "chapter": this.chapterId, "coins": this.coins});

      // Save username and firebaseid
      prefs.setString(PreferencesKey.username, name);
      prefs.setString(PreferencesKey.firebaseIdUser, ref.documentID);

      // Update state
      setState(() {
        this.logado = true;
        this.username = name;
      });

      //Update ranking
      _updateRanking();
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

  _updateRanking() async {
    //Create a temp list
    List<Ranking> rankingTemp = new List<Ranking>();

    //Add Andrew
    rankingTemp
        .add(Ranking(pos: 0, username: "andrew", chapter: 999, coins: 999));

    //Make the query
    QuerySnapshot query = await db
        .collection("users")
        .orderBy("chapter", descending: true)
        .orderBy("coins", descending: true)
        .limit(100)
        .getDocuments();

    //Make the ranking
    int i = 0;
    for (var userData in query.documents) {
      i += 1;
      Map<String, dynamic> data = userData.data;
      Ranking temp = Ranking(
        pos: i,
        username: data["username"],
        chapter: data["chapter"],
        coins: data["coins"],
      );
      rankingTemp.add(temp);

      //Find user ranking
      if (logado) {
        if (temp.username == this.username) {
          setState(() {
            this.userRanking = temp;
          });
        }
      }
    }

    //Refresh state
    setState(() {
      this.listRanking = rankingTemp;
    });
  }
}
