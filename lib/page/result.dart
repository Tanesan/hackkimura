import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var _pressures = List<double>.empty();
  var _score;
  bool _calculated = false;

  int _calculateScore(List<double> pressures) {
    return 80;
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    _pressures = ModalRoute.of(context)?.settings.arguments as List<double>;
    _score = _calculateScore(_pressures);
    _calculated = true;
    return Scaffold(
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
        body: _calculated
            ? Column(children: _pressures.map((pressure) => Text('$pressure, ')).toList())
            : CircularProgressIndicator());
  }
}
