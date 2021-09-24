import 'package:flutter/material.dart';
import 'dart:async';

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

  @override
  void initState() {
    super.initState();
    environmentSensors.pressure.listen((pressure) {
      print(pressure.toString());
      _pressures.add(pressure);
      _time.add(DateTime.now());
    });
    initPlatformState();
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
            title: const Text('Environment Sensors'),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            (_pressureAvailable)
                ? StreamBuilder<double>(
                stream: environmentSensors.pressure,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Text(
                      '圧力: ${snapshot.data?.toStringAsFixed(2)}');
                })
                : Text('気圧センサが利用できません。気圧センサが利用できる端末をご利用ください。'),
            ElevatedButton(onPressed: _finishMeasurement , child: Text('測定終了'))
          ])),
    );
  }
}