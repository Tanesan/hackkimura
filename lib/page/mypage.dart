import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackkimura/model/UserData.dart';
import 'package:hackkimura/model/UserScoreResponse.dart';
import 'package:hackkimura/model/UserScoreRequest.dart';

class Grade extends StatefulWidget {
  const Grade({Key? key}) : super(key: key);

  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> with SingleTickerProviderStateMixin {
  Future<UserScoreResponse> _getResult(UserData userData) async {
    var url = Uri.parse('http://52.193.204.138:5000/class');
    UserScoreRequest request = UserScoreRequest(
        className: userData.classCode, userName: userData.name);
    final response = await http.post(url,
        body: json.encode(request.toJson()),
        headers: {"Content-Type": "application/json"});
    return UserScoreResponse.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var userData = ModalRoute.of(context)?.settings.arguments as UserData;
    final Brightness platformBrightness =
        MediaQuery.platformBrightnessOf(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.08,
                    right: size.width * 0.08,
                    left: size.width * 0.08),
                child: FutureBuilder<UserScoreResponse>(
                    future: _getResult(userData),
                    builder: (context, snapshot) {
                      return Column(children: [
                        Container(
                          width: double.infinity,
                          child: Text("ようこそ",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(userData.name,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline4),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.04),
                            child: Row(children: <Widget>[
                              Container(
                                decoration:
                                    platformBrightness != Brightness.light
                                        ? BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color: Color(0xAE216EF3),
                                              spreadRadius: 0.0001,
                                              blurRadius: 24.0,
                                              offset: Offset(0, 0),
                                            ),
                                          ])
                                        : null,
                                child: Card(
                                    // color: Colors.lightBlueAccent,
                                    // color: _color!.value,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      child: Column(children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    size.height * 0.03),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: size.width * 0.25,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              !snapshot.hasData ||
                                                                      snapshot
                                                                          .hasError
                                                                  ? "--"
                                                                  : snapshot
                                                                      .data!
                                                                      .rank
                                                                      .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline3),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4.0,
                                                                    top: 13.0),
                                                            child: Text("位",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle2),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Text("in class",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                    )),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.07),
                                  child: Container(
                                    decoration:
                                        platformBrightness != Brightness.light
                                            ? BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x7A000000),
                                                  spreadRadius: 1.0,
                                                  blurRadius: 24.0,
                                                  offset: Offset(0, 0),
                                                ),
                                              ])
                                            : null,
                                    child: Card(
                                        // color: Colors.grey[900],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      size.height * 0.03),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width:
                                                            size.width * 0.21,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 2),
                                                              child: Text(
                                                                  !snapshot.hasData ||
                                                                          snapshot
                                                                              .hasError
                                                                      ? "--"
                                                                      : snapshot
                                                                          .data!
                                                                          .bestScore
                                                                          .toString(),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline3),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4.0,
                                                                      top:
                                                                          13.0),
                                                              child: Text("p",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle2),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Text("best score",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ])),
                                  ))
                            ])),
                        Padding(
                          padding: EdgeInsets.only(top: 24, bottom: 8),
                          child: Text("-やり方紹介-"),
                        ),
                        Row(children: [
                          Card(
                              // color: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new InkWell(
                                  onTap: () {
                                    userData.chooseMode = "training";
                                    Navigator.of(context).pushNamed('/howtoplay', arguments: userData);
                                  },
                                  child: Column(children: [
                                    Container(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              size.height * 0.03),
                                          child: Container(
                                            child: Text("胸骨圧迫やり方",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                          ),
                                        )
                                      ],
                                    ))
                                  ]))),
                          Card(
                              // color: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new InkWell(
                                  onTap: () {
                                    userData.chooseMode = "training";
                                    Navigator.of(context).pushNamed('/explain', arguments: userData);
                                  },
                                  child: Column(children: [
                                    Container(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              size.height * 0.03),
                                          child: Container(
                                            child: Text("遊び方",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                          ),
                                        )
                                      ],
                                    ))
                                  ]))),
                        ]),
                        Padding(
                          padding: EdgeInsets.only(top: 24, bottom: 8),
                          child: Text("-やってみよう-"),
                        ),
                        Card(
                              // color: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new InkWell(
                                  onTap: () {
                                    userData.chooseMode = "training";
                                    Navigator.of(context).pushNamed('/training',
                                        arguments: userData);
                                  },
                                  child: Column(children: [
                                    Container(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              size.height * 0.03),
                                          child: Container(
                                            width: double.infinity,
                                            child: Center(
                                              child: Text("一連の流れ練習モード",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                                  ]))),
                        Card(
                          // color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new InkWell(
                                onTap: () {
                                  userData.chooseMode = "training";
                                  Navigator.of(context).pushNamed('/training',
                                      arguments: userData);
                                },
                                child: Column(children: [
                                  Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                size.height * 0.03),
                                            child: Container(
                                              width: double.infinity,
                                              child: Center(
                                                child: Text("トレーニングモード",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ]))),
                        Card(
                          // color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new InkWell(
                                onTap: () {
                                  userData.chooseMode = "battle";
                                  Navigator.of(context).pushNamed('/training',
                                      arguments: userData);
                                },
                                child: Column(children: [
                                  Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                size.height * 0.03),
                                            child: Container(
                                              width: double.infinity,
                                              child: Center(
                                                child: Text("採点モード",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ]))),
                      ]);
                    }))));
  }
}
