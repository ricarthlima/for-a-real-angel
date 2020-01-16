import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_a_real_angel/screens/starter.dart';
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
          fontFamily: "JosefinSans"),
      home: Scaffold(
        body: Starter(),
      ),
    );
  }
}

_loadFirebase() async {
  Firestore db = Firestore.instance;

  db.collection("chapters").snapshots().listen(
    (snapshot) async {
      // Map de Maps
      Map<String, Map<String, dynamic>> chapters =
          new Map<String, Map<String, dynamic>>();

      // Percorrer a Query
      for (DocumentSnapshot queryCap in snapshot.documents) {
        var data = queryCap.data;
        chapters[data["id"].toString()] = data;
      }

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(PreferencesKey.chaptersList, jsonEncode(chapters));
    },
  );
}
