import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/APIResult.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var _args = BarometerArgs();
  var _score;
  var _result = APIResult();
  bool _calculated = false;

  int _calculateScore(List<double> pressures) {
    _calculated = true;
    return 80;
  }

  /*
  Future<void> _getResult(BarometerArgs args, int score) {
    final response = await http.post('');
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = json.decode(response.body);
      _result.average = decoded['average'];
      _result.rank = decoded['rank'];
      _result.topFiveUsers = decoded['topFive']['userName'];
      _result.topFiveScores = decoded['topFive']['score'];
      return list;
    } else {
      throw Exception('Fail to search repository');
    }
  }
   */

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)?.settings.arguments as BarometerArgs;
    _score = _calculateScore(_args.pressures);
//    _getResult(_args, _score);
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
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          _calculated
              ? Text(_args.pressures.join(','))
              : CircularProgressIndicator(),
          SizedBox(height: 100),
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
                  onPressed: () {
                    Navigator.of(context).pushNamed('/training');
                  })),
        ]))));
  }
}
