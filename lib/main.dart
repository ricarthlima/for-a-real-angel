import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/screens/starter_screen.dart';
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
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale("en"), Locale("pt")],
      title: 'F(or) a Real Angel',
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

  prefs.setString(PreferencesKey.newVersion, null);

  DocumentSnapshot versionQueryQuery =
      await db.collection("version").document("version").get();
  Map<String, dynamic> versionQuery = versionQueryQuery.data;
  if (InternalVersion.version < versionQuery["pubCode"]) {
    prefs.setString(PreferencesKey.newVersion, jsonEncode(versionQuery));
  }
}
