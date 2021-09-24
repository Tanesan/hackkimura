import 'package:flutter/material.dart';
import 'page/top.dart';
import 'page/select.dart';
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
        // default
        // primarySwatch: Colors.cyan,
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.blueGrey[600],
      ),
      home: Grade(),
      routes: <String,WidgetBuilder>{
        // '/home': (BuildContext context) => MyHomePage(),
        // '/profile': (BuildContext context) => ProfilePage(),
        // '/start': (BuildContext context) => StartPage(),
        // '/bottom': (BuildContext context) => BottomNavgationBarPage(),
        // '/name': (BuildContext context) => InputName(),
      },
    );
  }
}