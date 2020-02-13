import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel_demo/screens/starter_screen.dart';
import 'package:for_a_real_angel_demo/values/internalVersion.dart';
import 'package:for_a_real_angel_demo/values/local_chapters.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  _loadData();
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
      home: Scaffold(
        body: StarterScreen(),
      ),
    );
  }
}

_loadData() async {
  final prefs = await SharedPreferences.getInstance();
  if (InternalVersion.isDemo) {
    prefs.setString(PreferencesKey.chaptersList, LocalChapters.demoData);
  } else {}
}

_verifyInternalUserCode() async {
  final prefs = await SharedPreferences.getInstance();
  final userCode = prefs.getString(PreferencesKey.internalUserKey);

  if (userCode == null) {
    prefs.setString(PreferencesKey.internalUserKey, randomAlphaNumeric(32));
  }
}
