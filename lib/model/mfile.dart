import 'package:flutter/material.dart';

class MFile {
  final int chapter;

  final String icon;
  final String title;
  final String type;

  final String downlink;
  final String filePath;

  final String description;
  final String size;

  const MFile(
      {@required this.chapter,
      @required this.icon,
      @required this.title,
      @required this.type,
      this.filePath,
      this.downlink,
      this.description,
      this.size});
}

class MFileTypes {
  static const String text = "TEXT";
  static const String image = "IMAGE";
  static const String audio = "AUDIO";
  static const String other = "OTHER";
}

class MFolder {
  final int chapter;
  final String title;
  final List<MFile> listFiles;
  final List<MFolder> listFolders;

  const MFolder(
      {@required this.chapter,
      @required this.title,
      @required this.listFiles,
      @required this.listFolders});
}
