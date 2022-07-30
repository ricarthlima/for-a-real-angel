import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/mfile.dart';

class ExplorerListFile extends StatefulWidget {
  final MFile file;
  const ExplorerListFile({Key? key, required this.file}) : super(key: key);

  @override
  State<ExplorerListFile> createState() => _ExplorerListFileState();
}

class _ExplorerListFileState extends State<ExplorerListFile> {
  @override
  Widget build(BuildContext context) {
    MFile file = widget.file;

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            file.icon,
            height: 35,
            width: 35,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 7),
          ),
          Text(
            file.title,
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
