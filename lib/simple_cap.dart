import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/chapter.dart';
import 'package:for_a_real_angel/values/chapters_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleCap extends StatefulWidget {
  @override
  _SimpleCapState createState() => _SimpleCapState();
}

class _SimpleCapState extends State<SimpleCap> {
  int idChapter;
  TextEditingController _controllerCode = TextEditingController();

  List<Chapter> chapters = [
    Chapter(0, Icons.ac_unit, "", "", "", "-159-"),
    Chapters.cap01,
    Chapters.cap02,
    Chapters.cap03,
    Chapters.cap04,
    Chapters.cap05
  ];

  @override
  void initState() {
    // TODO: implement initState
    idChapter = 0;
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    Chapter cap = chapters[idChapter];

    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(25, 50, 25, 25),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Icon(cap.icon),
            Text(cap.title),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Text(
              cap.text,
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text(
              cap.tipQuote,
              style: TextStyle(color: Colors.orange, fontSize: 20),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: EdgeInsets.only(top: 35),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 3),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "PROJETO K22B",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "CourierPrime",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Text(
                    "ARMAZENAMENTO EXTREMAMENTE COMPROMETIDO",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: "CourierPrime",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                  ),
                  Text(
                    "Insira código de restaraução para recuperar setor defeituoso:",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "CourierPrime",
                    ),
                  ),
                  TextField(
                    controller: _controllerCode,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "CourierPrime",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _testCode(_controllerCode.text, context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black,
                      child: Text(
                        "RESTAURAR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "CourierPrime",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'chapter_id';
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

  _testCode(String value, BuildContext context) {
    bool correct = false;
    int i = 1;
    while (i < chapters.length) {
      if (value == chapters[i].code) {
        correct = true;
        break;
      }
      i += 1;
    }

    if (correct) {
      setState(() {
        idChapter = chapters[i].id;
      });
    } else {}
  }

  _save(int chapterId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'chapter_id';
    final value = chapterId;
    prefs.setInt(key, value);
  }
}
