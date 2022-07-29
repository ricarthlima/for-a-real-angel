import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:for_a_real_angel/values/internal_version.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'is_debug.dart';

saveFirebaseInternalInfo() async {
  if (!isInDebugMode()) {
    final prefs = await SharedPreferences.getInstance();
    FirebaseFirestore db = FirebaseFirestore.instance;

    final userInternalKey = prefs.getString(PreferencesKey.internalUserKey);
    final lvl = prefs.getInt(PreferencesKey.chapterId);

    db.collection("userProgressData").doc(userInternalKey).set({
      "level": lvl.toString(),
      "timestamp": DateTime.now().toString(),
      "version": InternalVersion.version
    });
  }
}
