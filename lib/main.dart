import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:for_a_real_angel_demo/localizations.dart';
import 'package:for_a_real_angel_demo/screens/starter_screen.dart';
import 'package:for_a_real_angel_demo/values/internalVersion.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  _verifyVersion();
  _verifyInternalUserCode();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale("en"), Locale("pt")],
      title: 'F(or) a Real Angel - Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        fontFamily: "JosefinSans",
      ),
      home: Scaffold(body: StarterScreen()),
    );
  }
}

_verifyVersion() async {
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

_verifyInternalUserCode() async {
  final prefs = await SharedPreferences.getInstance();
  final userCode = prefs.getString(PreferencesKey.internalUserKey);

  if (userCode == null) {
    prefs.setString(PreferencesKey.internalUserKey, randomAlphaNumeric(32));
  }
}
