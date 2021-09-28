import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackkimura/model/UserData.dart';
import 'package:hackkimura/model/UserScoreResponse.dart';
import 'package:hackkimura/model/UserScoreRequest.dart';

class Grade extends StatelessWidget {
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
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.08,
                    right: size.width * 0.08,
                    left: size.width * 0.08),
                child: FutureBuilder<UserScoreResponse>(
                    future: _getResult(userData),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.hasError) {
                        return Column(children: [
                          Container(
                            width: double.infinity,
                            child: Text("ようこそ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white60)),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(userData.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: size.height * 0.04),
                              child: Row(children: [
                                Card(
                                  color: Colors.lightBlueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                                  width: 60,
                                                  child: Row(
                                                    children: [
                                                      Text("--",
                                                          style: TextStyle(
                                                              fontSize: 40,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0,
                                                                top: 13.0),
                                                        child: Text("位",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text("in class",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white60)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    child: Card(
                                        color: Colors.grey[900],
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
                                                        width: 110,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Text("--",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          40,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4.0,
                                                                      top:
                                                                          13.0),
                                                              child: Text("p",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Colors
                                                                          .white)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Text("best score",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white60)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ])))
                              ])),
                          Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: Center(
                              child: Container(
                                width: 300.0,
                                height: 50.0,
                                child: OutlinedButton(
                                  child: const Text('いつものやつ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/training',
                                        arguments: userData);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 300.0,
                                height: 50.0,
                                child: OutlinedButton(
                                  child: const Text('重力そのままのやつ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/battle',
                                        arguments: userData);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]);
                      } else {
                        return Column(children: [
                          Container(
                            width: double.infinity,
                            child: Text("ようこそ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white60)),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(userData.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.04),
                            child: Row(
                              children: [
                                Card(
                                  color: Colors.lightBlueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                                  width: 80,
                                                  child: Row(
                                                    children: [
                                                      Text(snapshot.data!.rank.toString(),
                                                          style: TextStyle(
                                                              fontSize: 40,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0,
                                                                top: 13.0),
                                                        child: Text("位",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text("in class",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white60)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    child: Card(
                                      color: Colors.grey[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                                      width: 110,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: Text(
                                                                snapshot.data
                                                                    !.bestScore.toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        40,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4.0,
                                                                    top: 13.0),
                                                            child: Text("p",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .white)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Text("best score",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .white60)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: Center(
                              child: Container(
                                width: 300.0,
                                height: 50.0,
                                child: OutlinedButton(
                                  child: const Text('いつものやつ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/training',
                                        arguments: userData);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                width: 300.0,
                                height: 50.0,
                                child: OutlinedButton(
                                  child: const Text('重力そのままのやつ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/battle',
                                        arguments: userData);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }
                    }))));
  }
}
