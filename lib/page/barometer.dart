import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:quiver/async.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:flutter_barometer_plugin/flutter_barometer.dart';

class Barometer extends StatefulWidget {
  @override
  _BarometerState createState() => _BarometerState();
}

class _BarometerState extends State<Barometer> {
  var _pressures = <double>[];
  var _time = <int>[];

  int _start = 5;
  int _current = 5;
  var _startTime;

  var args = BarometerArgs();

  void _startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start), //初期値
      new Duration(seconds: 1), // 減らす幅
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds; //毎秒減らしていく
      });
    });

    sub.onDone(() {
      sub.cancel();
      _pressures.add(0.1);
      _pressures.add(0.2);
      _time.add(DateTime.now().difference(_startTime).inMilliseconds);
      _time.add(DateTime.now().difference(_startTime).inMilliseconds);
      FlutterBarometer.currentPressureEvent.listen((event) {
        _pressures.add(event.hectpascal.round() / 1000);
        _time.add(DateTime.now().difference(_startTime).inMilliseconds);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _startTimer();
    _startTime = DateTime.now();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    String platformVersion;
    try {
      platformVersion =
          await FlutterBarometer.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _finishMeasurement() {
    args.pressures = _pressures;
    args.time = _time;
    Navigator.of(context).pushNamed("/result", arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as BarometerArgs;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
              title: Text(args.mode == "training" ? 'トレーニングモード' : '採点モード'),
              backgroundColor: Colors.blueGrey[600]
              // 右側のアイコン一覧
              /*
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
             */
              ),
          body: Center(
              child: _current > 0
                  ? Column(mainAxisSize: MainAxisSize.min, children: [
                      Text("測定開始まで",
                          style: Theme.of(context).textTheme.headline4),
                      Text("$_current秒",
                          style: Theme.of(context).textTheme.headline4)
                    ])
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          SizedBox(height: 50),
                          Container(
                              width: 300.0,
                              height: 50.0,
                              child: OutlinedButton(
                                child: const Text('測定終了'),
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: const StadiumBorder(),
                                  side: const BorderSide(color: Colors.green),
                                ),
                                onPressed: _finishMeasurement,
                              )),
                        ]))),
    );
  }
}
