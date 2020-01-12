import 'package:flutter/material.dart';
import 'package:for_a_real_angel/model/mfile.dart';
import 'package:for_a_real_angel/values/icons_values.dart';

class ExplorerListFile extends StatefulWidget {
  MFile file;
  ExplorerListFile({@required this.file});

  @override
  _ExplorerListFileState createState() => _ExplorerListFileState();
}

class _ExplorerListFileState extends State<ExplorerListFile> {
  @override
  Widget build(BuildContext context) {
    MFile file = widget.file;

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            file.icon,
            height: 35,
            width: 35,
          ),
          Padding(
            padding: EdgeInsets.only(right: 7),
          ),
          Text(
            file.title,
            style: TextStyle(
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
