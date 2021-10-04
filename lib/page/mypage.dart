import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackkimura/model/UserData.dart';
import 'package:hackkimura/model/UserScoreResponse.dart';
import 'package:hackkimura/model/UserScoreRequest.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:games_services/games_services.dart';

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
                      Container(
                      width: double.infinity,
                      child: Text("豊田組(所属名)",
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyText1)
                      ),
                        Container(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () async {
                                final result =
                                    await GamesServices.showLeaderboards(
                                        iOSLeaderboardID: 'training_score');
                              },
                              child: Text("Game Center>>",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.subtitle1),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.04),
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      child: Column(children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.03,
                                                    //  right:size.width * 0.03,
                                                    top: size.height * 0.02,
                                                    bottom: size.height * 0.02),
                                                child: Container(
                                                  width: size.width * 0.345,
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
                                                            color: Colors.green,
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
                                                                EdgeInsets.all(
                                                                    size.height *
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
                                                            size.width * 0.25,
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
                                                                      top:
                                                                          13.0),
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
                                                          style:
                                                              Theme.of(context)
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
                                padding:
                                    EdgeInsets.only(left: size.width * 0.04),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(children: [
                                        Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.03,
                                                    top: size.height * 0.02,
                                                    bottom: size.height * 0.02),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .deepOrangeAccent,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .deepOrangeAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: size.height *
                                                                0.008,
                                                            bottom:
                                                                size.height *
                                                                    0.01,
                                                            left: size.height *
                                                                0.008,
                                                            right: size.height *
                                                                0.01,
                                                          ),
                                                          child: Icon(
                                                              FontAwesomeIcons
                                                                  .star,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.345,
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
                                                                    top: 13.0),
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
                                                        style: Theme.of(context)
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
                          padding: EdgeInsets.only(top: size.height * 0.02),
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: size.width * 0.03,
                                                  top: size.height * 0.02,
                                                  bottom: size.height * 0.02),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                        border: Border.all(
                                                            color: Colors
                                                                .deepOrangeAccent),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: size.height *
                                                              0.01,
                                                          bottom: size.height *
                                                              0.01,
                                                          left: size.height *
                                                              0.008,
                                                          right: size.height *
                                                              0.015,
                                                        ),
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .dumbbell,
                                                            size: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width * 0.345,
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
                                                                  top: 13.0),
                                                          child: Text("count",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Text("training counts",
                                                      style: Theme.of(context)
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
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.04),
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
                                                            color: Colors
                                                                .deepOrangeAccent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .deepOrangeAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: size.height *
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
                                                                    .signal,
                                                                size: 20,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            size.width * 0.345,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 2),
                                                              child: Text("グラフ",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline4),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text("score graph",
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
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          decoration: platformBrightness != Brightness.light
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
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Container(
                            decoration: platformBrightness != Brightness.light
                                ? BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Color(0x7A000000),
                                spreadRadius: 1.0,
                                blurRadius: 24.0,
                                offset: Offset(0, 0),
                              ),
                            ])
                                : null,
                            child: new InkWell(
                                onTap: () async {
                                  final result =
                                  await GamesServices.showLeaderboards(
                                      iOSLeaderboardID: 'training_score');
                                },
                                child: Card(
                                  // color: Colors.grey[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: size.width * 0.03,
                                                  top: size.height * 0.02,
                                                  bottom: size.height * 0.02),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom: 8.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            border: Border.all(
                                                                color: Colors.blue),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                top: size.height * 0.01,
                                                                bottom: size.height * 0.01,
                                                                right: size.height * 0.015,
                                                                left: size.height * 0.01),
                                                            child: Icon(
                                                                FontAwesomeIcons
                                                                    .gamepad,
                                                                size: 20,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 16),
                                                        child: Text("final login date",
                                                            style: Theme.of(
                                                                context)
                                                                .textTheme
                                                                .subtitle2),
                                                      )
                                                    ],
                                                  ),
                                                  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(0),
                                                      child: Text(
                                                                  "2021.12.10",
                                                                  style: Theme.of(
                                                                      context)
                                                                      .textTheme
                                                                      .headline3),
                                                    ),
                                                  ),
                                                  // Center(
                                                  //   child: Padding(
                                                  //     padding:
                                                  //     const EdgeInsets
                                                  //         .only(
                                                  //         left: 4.0,
                                                  //         top: 13.0),
                                                  //     child: Text("final login date",
                                                  //         style: Theme.of(
                                                  //             context)
                                                  //             .textTheme
                                                  //             .subtitle2),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24, bottom: 8),
                          child: Text("-やり方紹介-"),
                        ),
                        Row(children: [
                          Container(
                            decoration: platformBrightness != Brightness.light
                                ? BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF000000),
                                      spreadRadius: 5.0,
                                      blurRadius: 20.0,
                                      offset: Offset(0, 0),
                                    ),
                                  ])
                                : null,
                            child: Card(
                                // color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: new InkWell(
                                    onTap: () {
                                      userData.chooseMode = "training";
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
                                              child: Text("胸骨圧迫やり方",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                            ),
                                          )
                                        ],
                                      ))
                                    ]))),
                          ),
                          Container(
                            child: Card(
                                // color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: new InkWell(
                                    onTap: () {
                                      userData.chooseMode = "training";
                                      Navigator.of(context).pushNamed(
                                          '/explain',
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
                                              child: Text("遊び方",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                            ),
                                          )
                                        ],
                                      ))
                                    ]))),
                          ),
                        ]),
                        Row(children: [
                          Container(
                            // decoration: platformBrightness != Brightness.light
                            //     ? BoxDecoration(boxShadow: [
                            //         BoxShadow(
                            //           color: Color(0xFF000000),
                            //           spreadRadius: 5.0,
                            //           blurRadius: 20.0,
                            //           offset: Offset(0, 0),
                            //         ),
                            //       ])
                            //     : null,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                  // color: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: new InkWell(
                                      onTap: () {
                                        userData.chooseMode = "training";
                                        Navigator.of(context).pushNamed(
                                            '/emergency',
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
                                                child: Text("救急蘇生法について",
                                                    style: Theme.of(context)
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
                                        padding:
                                            EdgeInsets.all(size.height * 0.03),
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
                                        padding:
                                            EdgeInsets.all(size.height * 0.03),
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
                                        padding:
                                            EdgeInsets.all(size.height * 0.03),
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
                        Padding(
                          padding: EdgeInsets.only(top: 24, bottom: 8),
                          child: Text("-トップページ-"),
                        ),
                        Card(
                            // color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/top', arguments: userData);
                                },
                                child: Column(children: [
                                  Container(
                                      child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.all(size.height * 0.03),
                                        child: Container(
                                          child: Center(
                                            child: Text("トップページ",
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
