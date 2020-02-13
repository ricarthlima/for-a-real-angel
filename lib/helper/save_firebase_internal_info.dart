import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:for_a_real_angel/values/internalVersion.dart';
import 'package:for_a_real_angel/values/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'is_debug.dart';

saveFirebaseInternalInfo() async {
  if (!isInDebugMode()) {
    final prefs = await SharedPreferences.getInstance();
    Firestore db = Firestore.instance;

    final userInternalKey = prefs.getString(PreferencesKey.internalUserKey);
    final lvl = prefs.getInt(PreferencesKey.chapterId);

    db.collection("userProgressData").document(userInternalKey).setData({
      "level": lvl.toString(),
      "timestamp": DateTime.now().toString(),
      "version": InternalVersion.version
    });
  }
}
