import 'package:flutter/material.dart';
import 'package:for_a_real_angel/simple_cap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'For a Real Angel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          fontFamily: "JosefinSans"),
      home: Scaffold(
        body: SimpleCap(),
      ),
    );
  }
}
