import 'package:flutter/material.dart';
import 'page/top.dart';
import 'page/select.dart';
import 'page/barometer.dart';
import 'page/result.dart';

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
        // default
        // primarySwatch: Colors.cyan,
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.blueGrey[600],
      ),
      home: Barometer(),
      routes: <String,WidgetBuilder>{
        '/top': (BuildContext context) => Top(),
        '/select': (BuildContext context) =>Select(),
        '/result': (BuildContext context) => Result(),
        '/barometer': (BuildContext context) => Barometer(),
      },
    );
  }
}