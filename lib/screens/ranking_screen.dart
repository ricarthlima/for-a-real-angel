import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/custom_dialog.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/model/ranking.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:for_a_real_angel/partials/menu_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String username = "";
  bool logado = false;
  int coins = 0;
  int chapterId = 0;

  final TextEditingController _controllerCode = TextEditingController();

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getMenuBar(
        context: context,
        icon: IconsValues.console,
        title: "ranking",
      ),
      body: Container(
        height: size.height,
        padding: const EdgeInsets.all(25),
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
                        const TableRow(children: [
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
                              userRanking.pos.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              userRanking.username!,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              userRanking.chapter.toString(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              userRanking.coins.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(),
              (!logado)
                  ? Text(AppLocalizations.of(context)!.notSignUp)
                  : Container(),
              (!logado)
                  ? TextField(
                      controller: _controllerCode,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "CourierPrime",
                      ),
                      textAlign: TextAlign.left,
                      showCursor: true,
                      maxLines: 1,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.putUsername,
                        prefixIcon: const Icon(
                          Icons.account_circle,
                        ),
                        helperText:
                            AppLocalizations.of(context)!.usernameDisclaimer,
                      ),
                      maxLength: 7,
                    )
                  : Container(),
              (!logado)
                  ? GestureDetector(
                      onTap: () {
                        _authenticateUser(context, _controllerCode.text);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2.0,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              const Text(
                "RANKING MUNDIAL",
                style: TextStyle(color: Colors.yellow),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Table(
                children: [
                  const TableRow(children: [
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
                  for (var rank in listRanking)
                    TableRow(children: [
                      Text(
                        rank.pos.toString(),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        rank.username!,
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
        chapterId = capId;
      } else {
        chapterId = 1;
      }
    });
  }

  _authenticateUser(BuildContext context, String name) async {
    // Make a query to check username
    QuerySnapshot query =
        await db.collection("users").where("username", isEqualTo: name).get();

    if (query.docs.isEmpty) {
      final prefs = await SharedPreferences.getInstance();

      // Add to Firebase
      DocumentReference ref = await db
          .collection("users")
          .add({"username": name, "chapter": chapterId, "coins": coins});

      // Save username and firebaseid
      prefs.setString(PreferencesKey.username, name);
      prefs.setString(PreferencesKey.firebaseIdUser, ref.id);

      // Update state
      setState(() {
        logado = true;
        username = name;
      });

      //Update ranking
      _updateRanking();
    } else {
      showErrorDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.usernameTaked,
      );
    }
  }

  _updateRanking() async {
    //Create a temp list
    List<Ranking> rankingTemp = [];

    //Add Andrew
    rankingTemp
        .add(Ranking(pos: 0, username: "andrew", chapter: 999, coins: 999));

    //Make the query
    QuerySnapshot query = await db
        .collection("users")
        .orderBy("chapter", descending: true)
        .orderBy("coins", descending: true)
        .limit(100)
        .get();

    //Make the ranking
    int i = 0;
    for (var userData in query.docs) {
      i += 1;
      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
      Ranking temp = Ranking(
        pos: i,
        username: data["username"],
        chapter: data["chapter"],
        coins: data["coins"],
      );
      rankingTemp.add(temp);

      //Find user ranking
      if (logado) {
        if (temp.username == username) {
          setState(() {
            userRanking = temp;
          });
        }
      }
    }

    //Refresh state
    setState(() {
      listRanking = rankingTemp;
    });
  }
}
