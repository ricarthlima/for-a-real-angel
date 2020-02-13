import 'package:flutter/material.dart';
import 'package:for_a_real_angel_demo/helper/sound_player.dart';
import 'package:for_a_real_angel_demo/model/mfile.dart';
import 'package:for_a_real_angel_demo/values/icons_values.dart';
import 'package:for_a_real_angel_demo/values/my_colors.dart';
import 'package:for_a_real_angel_demo/partials/menu_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageViewerScreen extends StatefulWidget {
  final MFile file;
  SoundPlayer soundPlayer;
  ImageViewerScreen({@required this.file, this.soundPlayer});

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getMenuBar(
        icon: IconsValues.image,
        title: widget.file.title,
        context: context,
        soundPlayer: widget.soundPlayer,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchURL(widget.file.downlink);
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.cloud_download,
          color: MyColors.topBlue,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: MyColors.topBlue, width: 5),
        ),
        child: Image.asset(
          "assets/files/" + widget.file.filePath,
        ),
      ),
    );
  }
}
