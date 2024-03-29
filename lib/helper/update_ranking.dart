import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

updateRanking() async {
  final prefs = await SharedPreferences.getInstance();
  final idFirebase = prefs.getString(PreferencesKey.firebaseIdUser);

  if (idFirebase != null) {
    final name = prefs.getString(PreferencesKey.username);
    final chapter = prefs.getInt(PreferencesKey.chapterId);
    final coins = prefs.getInt(PreferencesKey.userCoins);

    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("users")
        .doc(idFirebase)
        .set({"username": name, "chapter": chapter, "coins": coins});
  }
}
