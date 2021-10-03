import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'page/top.dart';
import 'page/barometer.dart';
import 'page/result.dart';
import 'page/play.dart';
import 'page/mypage.dart';
import 'page/emergency.dart';
import 'page/AEDMap.dart';
import 'page/explain.dart';
import 'page/howtoplay.dart';
import 'page/sos.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LineSDK.instance.setup("${1656477616}").then((_) {
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
      theme: ThemeData.from(
          colorScheme:ColorScheme.light(primary: Colors.green),
          textTheme: Typography.material2018().black.copyWith(
              subtitle1: TextStyle(fontWeight: FontWeight.bold),
              subtitle2: TextStyle(fontWeight: FontWeight.bold),
              // headline3: TextStyle(color: Colors.white)
          )),
      darkTheme: ThemeData.from(
          colorScheme:ColorScheme.dark(primary: Colors.green),
          textTheme: Typography.material2018().white.copyWith(
              subtitle1: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white60),
              subtitle2: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white60),
              headline4: TextStyle(color: Colors.white),
              headline2: TextStyle(color: Colors.white),
              bodyText1: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              headline3: TextStyle(color: Colors.white))),
      home: Top(),
      routes: <String, WidgetBuilder>{
        '/top': (BuildContext context) => Top(),
        '/result': (BuildContext context) => Result(),
        '/barometer': (BuildContext context) => Barometer(),
        '/training': (BuildContext context) => Training(),
        '/grade': (BuildContext context) => Grade(),
        '/emergency': (BuildContext context) => Emergency(),
        '/mypage': (BuildContext context) => Grade(),
        '/explain': (BuildContext context) => Explain(),
        '/howtoplay': (BuildContext context) => Howtoplay(),
        '/sos': (BuildContext context) => Sos(),
        '/aed': (BuildContext context) => AEDMap()
      },
    );
  }
}
