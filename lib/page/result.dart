import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/ApiResults.dart';
import 'package:hackkimura/model/Request.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var _args = BarometerArgs();

  Future<ApiResults> _getResult(BarometerArgs args) async {
    var url = Uri.parse('http://52.193.204.138:5000');
    Request request = Request(
        className: _args.userData.classCode,
        userName: _args.userData.name,
        data: _args.pressures);
    final response = await http.post(url,
        body: json.encode(request.toJson()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return ApiResults.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to search repository');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _args = ModalRoute.of(context)?.settings.arguments as BarometerArgs;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
            title: Text(_args.mode == "training" ? 'トレーニングモード' : '採点モード'),
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
        body: SingleChildScrollView(
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 100),
          SelectableText(_args.pressures.join(',')),
          SizedBox(height: 100),
          SelectableText(_args.time.join(',')),
          SizedBox(height: 100),
          FutureBuilder<ApiResults>(
            future: _getResult(_args),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Text('クラスの平均点：${snapshot.data?.average.toString()} 点'),
                  Text('クラス内：第 ${snapshot.data?.rank.toString()} 位')
                ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
          SizedBox(height: 100),
          Container(
              width: 300.0,
              height: 50.0,
              child: OutlinedButton(
                  child: const Text('もう一度'),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/training'));
                  })),
        ]))));
  }
}
