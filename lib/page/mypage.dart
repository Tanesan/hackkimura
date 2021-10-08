import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackkimura/model/UserData.dart';
import 'package:hackkimura/model/UserScoreResponse.dart';
import 'package:hackkimura/model/UserScoreRequest.dart';
import 'package:hackkimura/model/ClassScoreRequest.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_game_center/ios_game_center.dart';

class Grade extends StatefulWidget {
  const Grade({Key? key}) : super(key: key);

  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> with SingleTickerProviderStateMixin {
  Future<UserScoreResponse> _getResult(UserData userData) async {
    var url = Uri.parse('http://52.193.204.138:5000/user');
    UserScoreRequest userRequest = UserScoreRequest(
        uuid: userData.id,
        userName: userData.name);
    print(userRequest.toJson());
    var response = await http.post(url,
        body: json.encode(userRequest.toJson()),
        headers: {"Content-Type": "application/json"});
    var userScoreResponse = UserScoreResponse.fromJson(json.decode(response.body));
    print(response.body);

    url = Uri.parse('http://52.193.204.138:5000/class');
    ClassScoreRequest classRequest = ClassScoreRequest(
        uuid: userData.id,
        className: userData.classCode,
        userName: userData.name);
    response = await http.post(url,
        body: json.encode(classRequest.toJson()),
        headers: {"Content-Type": "application/json"});
    userScoreResponse.rank = json.decode(response.body)['rank'];
    return userScoreResponse;
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                      _selectedIndex == 0
                          ? Column(children: [
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 24),
                                  child: Text("概要",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24)),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  child: Row(children: <Widget>[
                                    Container(
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
                                          // color: Colors.lightBlueAccent,
                                          // color: _color!.value,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: InkWell(
                                            splashColor:
                                                Colors.blue.withAlpha(30),
                                            child: Column(children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                              size.width * 0.03,
                                                          //  right:size.width * 0.03,
                                                          top: size.height *
                                                              0.02,
                                                          bottom: size.height *
                                                              0.02),
                                                      child: Container(
                                                        width:
                                                            size.width * 0.345,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .all(size
                                                                              .height *
                                                                          0.01),
                                                                  child: Icon(
                                                                      FontAwesomeIcons
                                                                          .award,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.25,
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
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            4.0,
                                                                        top:
                                                                            13.0),
                                                                    child: Text(
                                                                        "位",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subtitle2),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Text("クラス内順位",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle2),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.04),
                                      child: Container(
                                        decoration: platformBrightness !=
                                                Brightness.light
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
                                                      padding: EdgeInsets.only(
                                                          left:
                                                              size.width * 0.03,
                                                          top: size.height *
                                                              0.02,
                                                          bottom: size.height *
                                                              0.02),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        8.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top:
                                                                      size.height *
                                                                          0.008,
                                                                  bottom:
                                                                      size.height *
                                                                          0.01,
                                                                  left:
                                                                      size.height *
                                                                          0.008,
                                                                  right:
                                                                      size.height *
                                                                          0.01,
                                                                ),
                                                                child: Icon(
                                                                    FontAwesomeIcons
                                                                        .star,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: size.width *
                                                                0.345,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 2),
                                                                  child: Text(
                                                                      !snapshot.hasData ||
                                                                              snapshot
                                                                                  .hasError || snapshot
                                                                          .data!
                                                                          .bestScore.toString() == "null"
                                                                          ? "0"
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 4.0,
                                                                      top:
                                                                          13.0),
                                                                  child: Text(
                                                                      "点",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .subtitle2),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Text("最高スコア",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ])),
                                      ),
                                    ),
                                  ])),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.02),
                                child: Row(
                                  children: [
                                    Container(
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
                                                    padding: EdgeInsets.only(
                                                        left: size.width * 0.03,
                                                        top: size.height * 0.02,
                                                        bottom:
                                                            size.height * 0.02),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 8.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .blue),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top:
                                                                    size.height *
                                                                        0.01,
                                                                bottom:
                                                                    size.height *
                                                                        0.01,
                                                                left:
                                                                    size.height *
                                                                        0.008,
                                                                right:
                                                                    size.height *
                                                                        0.015,
                                                              ),
                                                              child: Icon(
                                                                  FontAwesomeIcons
                                                                      .dumbbell,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: size.width *
                                                              0.345,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            2),
                                                                child: Text(
                                                                    !snapshot.hasData ||
                                                                            snapshot
                                                                                .hasError
                                                                        ? "--"
                                                                        : snapshot
                                                                            .data!
                                                                            .numberOfTrainings
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
                                                                        left:
                                                                            4.0,
                                                                        top:
                                                                            13.0),
                                                                child: Text("回",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .subtitle2),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Text("トレーニング回数",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle2),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ])),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.04),
                                        child: Container(
                                          decoration: platformBrightness !=
                                                  Brightness.light
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
                                                        padding: EdgeInsets.only(
                                                            left: size.width *
                                                                0.03,
                                                            top: size.height *
                                                                0.02,
                                                            bottom:
                                                                size.height *
                                                                    0.02),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: size
                                                                            .height *
                                                                        0.01,
                                                                    bottom: size
                                                                            .height *
                                                                        0.01,
                                                                    left: size
                                                                            .height *
                                                                        0.008,
                                                                    right: size
                                                                            .height *
                                                                        0.015,
                                                                  ),
                                                                  child: Icon(
                                                                      FontAwesomeIcons
                                                                          .signal,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.345,
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            2),
                                                                    child: Text(
                                                                        !snapshot.hasData || snapshot.hasError
                                                                            ? "--"
                                                                            : snapshot.data!.scoreRate.toStringAsFixed(
                                                                                0),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline3),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            4.0,
                                                                        top:
                                                                            13.0),
                                                                    child: Text(
                                                                        "%",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subtitle2),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Text("スコアの伸び率",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle2),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ])),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
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
                              ),
                            ])
                          : Container(),

                      Column(children: [
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
                        Container(
                            width: double.infinity,
                            child: Text(userData.classCode,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.bodyText1)),
                        Container(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () async {
                                final result =
                                    await IOSGameCenter.showLeaderboard(
                                        'jp.hacks.kimura.training_score');
                              },
                              child: Text("リーダーボードを見る",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.subtitle2),
                            )),
                        Container(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('/top');
                              },
                              child: Text("ログアウト(トップページへ)",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.subtitle2),
                            ))
                      ]),

                      _selectedIndex == 1
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 24, bottom: 8),
                                      child: Text("やり方紹介",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24)),
                                    ),
                                  ),
                                  Row(children: [
                                    Container(
                                      decoration:
                                          platformBrightness != Brightness.light
                                              ? BoxDecoration(boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xFF000000),
                                                    spreadRadius: 5.0,
                                                    blurRadius: 10.0,
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
                                          child: new InkWell(
                                              onTap: () {
                                                userData.chooseMode =
                                                    "training";
                                                Navigator.of(context).pushNamed(
                                                    '/howtoplay',
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
                                                        child: Text("胸骨圧迫のやり方",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6),
                                                      ),
                                                    )
                                                  ],
                                                ))
                                              ]))),
                                    ),
                                  ]),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(children: [
                                      Container(
                                        child: Card(
                                            // color: Colors.grey[900],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: new InkWell(
                                                onTap: () {
                                                  userData.chooseMode =
                                                      "training";
                                                  Navigator.of(context)
                                                      .pushNamed('/explain',
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
                                                          child: Text(
                                                              "当アプリの遊び方",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6),
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                                ]))),
                                      ),
                                    ]),
                                  ),
                                  Row(children: [
                                    Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Card(
                                            // color: Colors.grey[900],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: new InkWell(
                                                onTap: () {
                                                  userData.chooseMode =
                                                      "training";
                                                  Navigator.of(context)
                                                      .pushNamed('/emergency',
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
                                                          child: Text(
                                                              "救急蘇生法について",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6),
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                                ]))),
                                      ),
                                    ),
                                  ]),
                                ])
                          : Container(),

                      _selectedIndex == 2
                          ? Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 24, bottom: 8),
                                    child: Text("やってみよう",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24)),
                                  ),
                                ),
                                Card(
                                    // color: Colors.grey[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: new InkWell(
                                        onTap: () {
                                          userData.chooseMode = "training";
                                          Navigator.of(context).pushNamed(
                                              '/training',
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
                                          Navigator.of(context).pushNamed(
                                              '/training',
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
                              ],
                            )
                          : Container(),

                      // Padding(
                      //   padding: EdgeInsets.only(top: 24, bottom: 8),
                      //   child: Text("-トップページ-"),
                      // ),
                      // Card(
                      //     // color: Colors.grey[900],
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: new InkWell(
                      //         onTap: () {
                      //           Navigator.of(context)
                      //               .pushNamed('/top', arguments: userData);
                      //         },
                      //         child: Column(children: [
                      //           Container(
                      //               child: Column(
                      //             children: [
                      //               Padding(
                      //                 padding:
                      //                     EdgeInsets.all(size.height * 0.03),
                      //                 child: Container(
                      //                   child: Center(
                      //                     child: Text("トップページ",
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .headline6),
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ))
                      //         ]))),
                    ]);
                  }))),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '概要',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: '遊び方',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: '遊ぶ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
