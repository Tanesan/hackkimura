import 'package:flutter/material.dart';
import 'page/top.dart';
import 'page/select.dart';
import 'page/barometer.dart';
import 'page/result.dart';
import 'page/battle.dart';
import 'page/training.dart';
import 'page/grade.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.black,
        primaryColor: Colors.green,
        accentColor: Colors.green,
      ),
      home: Top(),
      routes: <String,WidgetBuilder>{
        '/top': (BuildContext context) => Top(),
        '/select': (BuildContext context) =>Select(),
        '/result': (BuildContext context) => Result(),
        '/barometer': (BuildContext context) => Barometer(),
        '/battle': (BuildContext context) => Battle(),
        '/training': (BuildContext context) => Training(),
        '/grade': (BuildContext context) => Grade(),
      },
    );
  }
}