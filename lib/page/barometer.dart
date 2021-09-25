import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quiver/async.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:sensors/sensors.dart';

class Barometer extends StatefulWidget {
  @override
  _BarometerState createState() => _BarometerState();
}

class _BarometerState extends State<Barometer> {
  bool _pressureAvailable = false;
  var _pressures = <double>[];
  var _time = <int>[];
  var _startTime;

  int _start = 5;
  int _current = 5;

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
      _startTime = DateTime.now();
      _pressures.add(0.1);
      _pressures.add(0.2);
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
                          (_pressureAvailable)
                              ? StreamBuilder<UserAccelerometerEvent>(
                                  stream: userAccelerometerEvents,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return Text(
                                        'velocity: ${snapshot.data?.x} ${snapshot.data?.y} ${snapshot.data?.z} ');
                                  })
                              : Column(children: [
                                  Text('気圧センサが利用できません。'),
                                  Text('気圧センサが利用できる端末をご利用ください。')
                                ]),
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
