import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/icons_values.dart';

class ExplorerListFolder extends StatefulWidget {
  final MFolder folder;
  const ExplorerListFolder({Key? key, required this.folder}) : super(key: key);

  @override
  State<ExplorerListFolder> createState() => _ExplorerListFolderState();
}

class _ExplorerListFolderState extends State<ExplorerListFolder> {
  @override
  Widget build(BuildContext context) {
    MFolder folder = widget.folder;

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            IconsValues.directoryOpen,
            height: 35,
            width: 35,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 7),
          ),
          Text(
            folder.title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "CourierPrime",
              fontSize: 18,
              letterSpacing: -2,
              wordSpacing: -3,
            ),
          )
        ],
      ),
    );
  }
}
