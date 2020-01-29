import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_a_real_angel/screens/starter.dart';
import 'package:for_a_real_angel/values/internalVersion.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  _loadFirebase();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'For a Real Angel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        fontFamily: "JosefinSans",
      ),
      home: Scaffold(
        body: Starter(),
      ),
    );
  }
}

_loadFirebase() async {
  Firestore db = Firestore.instance;
  final prefs = await SharedPreferences.getInstance();
  final chapters = prefs.getString(PreferencesKey.chaptersList);

  prefs.setString(PreferencesKey.newVersion, null);

  DocumentSnapshot versionQueryQuery =
      await db.collection("version").document("version").get();
  Map<String, dynamic> versionQuery = versionQueryQuery.data;
  if (InternalVersion.version < versionQuery["pubCode"]) {
    prefs.setString(PreferencesKey.newVersion, jsonEncode(versionQuery));
    if (chapters == null) {
      _loadChapters();
    }
  } else {
    _loadChapters();
  }
}

_loadChapters() async {
  Firestore db = Firestore.instance;

  db.collection("chapters").snapshots().listen(
    (snapshot) async {
      // Map de Maps
      Map<String, Map<String, dynamic>> chapters =
          new Map<String, Map<String, dynamic>>();

      // Percorrer a Query
      for (DocumentSnapshot queryCap in snapshot.documents) {
        // Basic infos
        var data = queryCap.data;
        chapters[data["id"].toString()] = data;

        // closeTry Query
        QuerySnapshot closeTrysQuery = await db
            .collection("chapters")
            .document(data["id"].toString())
            .collection("closeTrys")
            .getDocuments();

        Map<String, String> closeTryEmbed = Map<String, String>();

        // Percorrer a closeTry Query
        List<DocumentSnapshot> closeTryList = closeTrysQuery.documents;
        for (DocumentSnapshot closeTry in closeTryList) {
          Map<String, dynamic> ctdata = closeTry.data;
          closeTryEmbed[closeTry.documentID] = ctdata["hint"];
        }

        //Embed Close Trys
        chapters[data["id"].toString()]["closeTrys"] = closeTryEmbed;
      }

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(PreferencesKey.chaptersList, jsonEncode(chapters));
    },
  );
}
