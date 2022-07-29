import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String> getChapterByLocale(BuildContext context) async {
  String filename = "_andrew.json";

  Locale myLocale = Localizations.localeOf(context);

  filename = myLocale.languageCode + filename;
  return await rootBundle.loadString("assets/chapters_json/$filename");
}
