import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:for_a_real_angel/helper/custom_dialog.dart';
import 'package:for_a_real_angel/helper/sound_player.dart';
import 'package:for_a_real_angel/localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../values/sounds.dart';

launchURL(BuildContext context, String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    showErrorDialog(
        context: context, title: AppLocalizations.of(context)!.downloadError);
    context.read<SoundPlayer>().playSFX(Sounds.idError);
  }
}

getFromStorage(BuildContext context, String fileName) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  String url = await storage.ref("files/$fileName").getDownloadURL();
  launchURL(context, url);
}
