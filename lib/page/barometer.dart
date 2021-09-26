import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quiver/async.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:sensors/sensors.dart';
import 'dart:isolate';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class Barometer extends StatefulWidget {
  @override
  _BarometerState createState() => _BarometerState();
}

class _BarometerState extends State<Barometer> {
  var _pressures = <double>[];
  var _time = <int>[];
  var _startTime;
  var _receivePort = ReceivePort();

  int _start = 5;
  int _current = 5;
  final player = AudioCache();

  var args = BarometerArgs();

  void _startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start), //初期値
      new Duration(seconds: 1), // 減らす幅
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        player.play('sound/sound.mp3');
        _current = _start - duration.elapsed.inSeconds; //毎秒減らしていく
      });
    });

    sub.onDone(() {
      sub.cancel();
      _startTime = DateTime.now();
      _pressures.add(0.1);
      _pressures.add(0.2);
      _incrementCounter();
      _time.add(DateTime.now().difference(_startTime).inMilliseconds);
      _time.add(DateTime.now().difference(_startTime).inMilliseconds);
      userAccelerometerEvents.listen((UserAccelerometerEvent event) {
        _pressures.add(_calcSpeed(event));
        _time.add(DateTime.now().difference(_startTime).inMilliseconds);
      });
    });
  }

  double _calcSpeed(UserAccelerometerEvent event) {
    return sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _finishMeasurement() {
    args.pressures = _pressures;
    args.time = _time;
    _receivePort.close();
    Navigator.of(context).pushNamed("/result", arguments: args);
  }

  int _counter = 60;

  Future<void> _incrementCounter() async {
    var sendPort = _receivePort.sendPort;
    late Capability capability;

    // 子供からメッセージを受け取る
    _receivePort.listen((message) {
      player.play('sound/sound.mp3');
      _counter--;
      if (message == 60) {
        _receivePort.close();
        _finishMeasurement();
      }
    });

    final isolate = await Isolate.spawn(child, sendPort);

    Timer(Duration(seconds: 30), () {
      isolate.kill();
      _receivePort.close();
      _finishMeasurement();
    });
    setState(() {});
  }

  // isolate.kill();
  static void child(SendPort sendPort) {
    int i = 0;
    // 親にメッセージを送る
    Timer.periodic(
        Duration(milliseconds: 500), (timer) => {sendPort.send(i++)});
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as BarometerArgs;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  _receivePort.close();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
            title: Text(args.mode == "training" ? 'トレーニングモード' : '採点モード'),
            backgroundColor: Colors.black,
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
                          style: TextStyle(color: Colors.white, fontSize: 32)),
                      Text("$_current",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 550,
                              fontWeight: FontWeight.bold))
                    ])
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          StreamBuilder<UserAccelerometerEvent>(
                              stream: userAccelerometerEvents,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Column(children: [
                                    Text('気圧センサが利用できません。',
                                        style: TextStyle(color: Colors.white)),
                                    Text('気圧センサが利用できる端末をご利用ください。',
                                        style: TextStyle(color: Colors.white))
                                  ]);
                                return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("残り",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32)),
                                      Text("${(_counter / 2).round()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 200,
                                              fontWeight: FontWeight.bold)),
                                      Text("秒",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32)),
                                    ]);
                              }),
                          SizedBox(height: 50),
                          Container(
                              width: 300.0,
                              height: 50.0,
                              child: OutlinedButton(
                                child: const Text('測定終了',
                                    style: TextStyle(color: Colors.white)),
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
