import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quiver/async.dart';

import 'package:environment_sensors/environment_sensors.dart';

class Barometer extends StatefulWidget {
  @override
  _BarometerState createState() => _BarometerState();
}

class _BarometerState extends State<Barometer> {
  bool _pressureAvailable = false;
  var _pressures = List<double>.empty();
  var _time = List<DateTime>.empty();
  final environmentSensors = EnvironmentSensors();

  int _start = 10;
  int _current = 10;

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
      print("Done");
      sub.cancel();
      environmentSensors.pressure.listen((pressure) {
        print(pressure.toString());
        _pressures.add(pressure);
        _time.add(DateTime.now());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _startTimer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool pressureAvailable;

    pressureAvailable =
        await environmentSensors.getSensorAvailable(SensorType.Pressure);

    setState(() {
      _pressureAvailable = pressureAvailable;
    });
  }

  void _finishMeasurement() {
    Navigator.of(context).pushNamed("/result", arguments: _pressures);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
            title: Text('トレーニングモード'),
            // 右側のアイコン一覧
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          body: Center(
              child: _current > 0
                  ? Text("$_current秒",
                      style: Theme.of(context).textTheme.headline4)
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          (_pressureAvailable)
                              ? StreamBuilder<double>(
                                  stream: environmentSensors.pressure,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return Text(
                                        '圧力: ${snapshot.data?.toStringAsFixed(2)}');
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
