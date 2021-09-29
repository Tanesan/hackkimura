import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'page/top.dart';
import 'page/barometer.dart';
import 'page/result.dart';
import 'page/play.dart';
import 'page/mypage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LineSDK.instance.setup("${1656472887}").then((_) {
    print("LineSDK Prepared");
  });
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
        primaryColor: Colors.black,
        accentColor: Colors.green,
      ),
      home: Top(),
      routes: <String, WidgetBuilder>{
        '/top': (BuildContext context) => Top(),
        '/result': (BuildContext context) => Result(),
        '/barometer': (BuildContext context) => Barometer(),
        '/training': (BuildContext context) => Training(),
        '/grade': (BuildContext context) => Grade(),
      },
    );
  }
}
