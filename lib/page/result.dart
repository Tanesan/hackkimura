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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
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
          Padding(
            padding: EdgeInsets.only(
                top: 16.0, left: size.width * 0.05, right: size.width * 0.05),
            child: Container(
                width: double.infinity,
                child: Text('結果発表',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 48))),
          ),
          FutureBuilder<ApiResults>(
            future: _getResult(_args),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03, right: size.width * 0.05),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text('総合得点：',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            Row(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.18),
                                child: Text(
                                    '${snapshot.data?.score.toString()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 48,
                                        fontWeight: FontWeight.w200)),
                              ),
                              SizedBox(width: 20),
                              Padding(
                                padding: EdgeInsets.only(top: 15, right: 8),
                                child: Text('点',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              )
                            ]),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text('クラスの平均点：',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            Row(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.18),
                                child: Text(
                                    '${snapshot.data?.average.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 48,
                                        fontWeight: FontWeight.w200)),
                              ),
                              SizedBox(width: 20),
                              Padding(
                                padding: EdgeInsets.only(top: 15, left: 8),
                                child: Text('点',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              )
                            ]),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text('クラス内順位：',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            Row(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.18),
                                child: Text('${snapshot.data?.rank.toString()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 48,
                                        fontWeight: FontWeight.w200)),
                              ),
                              SizedBox(width: 20),
                              Padding(
                                padding: EdgeInsets.only(top: 15, left: 8),
                                child: Text('位',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              )
                            ]),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      snapshot.data?.topFiveUsers.length < 3
                          ? Text('')
                          : Container(
                              height: 500,
                              child: Column(children: [
                                SizedBox(height: 100),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 16.0,
                                      left: size.width * 0.02,
                                      right: size.width * 0.05),
                                  child: Container(
                                      width: double.infinity,
                                      child: Text('クラスTop3',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40))),
                                ),
                                SizedBox(height: 20),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(
                                            '${snapshot.data?.topFiveUsers[0]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40)),
                                      ),
                                      Row(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.18),
                                          child: Text(
                                              '${snapshot.data?.topFiveScores[0].toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        SizedBox(width: 20),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: 15, left: 8),
                                          child: Text('点',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        )
                                      ]),
                                    ]),
                                Divider(color: Colors.white),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(
                                            '${snapshot.data?.topFiveUsers[1]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40)),
                                      ),
                                      Row(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.18),
                                          child: Text(
                                              '${snapshot.data?.topFiveScores[1].toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        SizedBox(width: 20),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: 15, left: 8),
                                          child: Text('点',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        )
                                      ]),
                                    ]),
                                Divider(color: Colors.white),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(
                                            '${snapshot.data?.topFiveUsers[1]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40)),
                                      ),
                                      Row(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.18),
                                          child: Text(
                                              '${snapshot.data?.topFiveScores[1].toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        SizedBox(width: 20),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: 15, left: 8),
                                          child: Text('点',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        )
                                      ]),
                                    ]),
                                Divider(color: Colors.white),
                              ])),
                    ]));
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
                  child: const Text('もう一度', style: TextStyle(fontSize: 24)),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
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
