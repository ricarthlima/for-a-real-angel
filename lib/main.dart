import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:for_a_real_angel/screens/starter_screen.dart';
import 'package:for_a_real_angel/values/internal_version.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SoundPlayer(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  _loadFirebase();
  _verifyInternalUserCode();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale("en"), Locale("pt")],
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
  FirebaseFirestore db = FirebaseFirestore.instance;
  final prefs = await SharedPreferences.getInstance();

  DocumentSnapshot versionQueryQuery =
      await db.collection("version").doc("version").get();

  Map<String, dynamic> versionQuery =
      versionQueryQuery.data() as Map<String, dynamic>;
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
