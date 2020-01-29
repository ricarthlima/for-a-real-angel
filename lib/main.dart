import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_a_real_angel_demo/screens/starter.dart';
import 'package:for_a_real_angel_demo/values/internalVersion.dart';
import 'package:for_a_real_angel_demo/values/local_chapters.dart';
import 'package:for_a_real_angel_demo/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  _loadData();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'F(or) a Real Angel - Demo',
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

_loadData() async {
  final prefs = await SharedPreferences.getInstance();
  if (InternalVersion.isDemo) {
    prefs.setString(PreferencesKey.chaptersList, LocalChapters.demoData);
  } else {}
}
