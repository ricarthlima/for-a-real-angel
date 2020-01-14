import 'package:flutter/material.dart';
import 'package:for_a_real_angel/values/icons_values.dart';

class TaskBar extends StatefulWidget {
  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  String hour = "";
  @override
  Widget build(BuildContext context) {
    _getHour();
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          color: Color.fromARGB(255, 192, 192, 192),
        ),
        height: 40,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: TaskBarButton(null, "Start"),
                ),
                Padding(padding: EdgeInsets.only(right: 2)),
                Text(
                  "|",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Padding(padding: EdgeInsets.only(right: 2)),
                Image.asset(
                  "assets/icons/desktop-0.png",
                  height: 20,
                ),
                Padding(padding: EdgeInsets.only(right: 2)),
                Text(
                  "|",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),

            // RELOGIO
            Container(
              height: 30,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 1),
                  left: BorderSide(color: Colors.grey, width: 1),
                  bottom: BorderSide(color: Colors.white, width: 1),
                  right: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    IconsValues.speaker_on,
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                  ),
                  Text(
                    hour,
                    style: TextStyle(
                        color: Colors.black, fontFamily: "CourierPrime"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _getHour() {
    setState(() {
      hour = DateTime.now().hour.toString() +
          ":" +
          ("0" + DateTime.now().minute.toString()).substring(0);
    });
  }
}

class TaskBarButton extends StatefulWidget {
  final String icon;
  final String text;

  TaskBarButton(this.icon, this.text);
  @override
  _TaskBarButtonState createState() => _TaskBarButtonState();
}

class _TaskBarButtonState extends State<TaskBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
          right: BorderSide(color: Colors.black, width: 1),
          top: BorderSide(color: Colors.white, width: 1),
          left: BorderSide(color: Colors.white, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          (widget.icon != null)
              ? Image.asset(
                  widget.icon,
                  height: 20,
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(right: 2),
          ),
          Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                fontFamily: "CourierPrime"),
          ),
        ],
      ),
    );
  }
}
