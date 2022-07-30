import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/icons_values.dart';
import 'package:for_a_real_angel/values/my_colors.dart';
import 'package:for_a_real_angel/partials/get_app_bar.dart';

import '../helper/laucher_url.dart';

class ImageViewer extends StatefulWidget {
  final MFile file;
  const ImageViewer({Key? key, required this.file}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppBar(
        icon: IconsValues.image,
        title: widget.file.title,
        context: context,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getFromStorage(context, widget.file.downlink!);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.cloud_download,
          color: MyColors.topBlue,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: MyColors.topBlue, width: 5),
        ),
        child: Image.asset(
          "assets/files/${widget.file.filePath!}",
        ),
      ),
    );
  }
}
