import 'package:flutter/material.dart';
import 'package:hackkimura/model/UserData.dart';
import 'package:flutter/services.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  UserData userData = UserData();
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/AED.jpg'),
                      fit: BoxFit.cover,
                    )),
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.4),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: size.width * 0.4),
                              child: Text('胸骨圧迫',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: size.width * 0.1),
                              child: Text('ペットボトルdeトレーニング',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    )),
                Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.15,
                        right: size.width * 0.1,
                        left: size.width * 0.1),
                    child: Center(
                      child: FocusScope(
                        child: Focus(
                          onFocusChange: (focus) => controller.animateTo(
                            size.height * 0.3,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          ),
                          child: TextField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'^[0-9a-zA-Z@_.-]+$')),
                              ],
                              maxLength: 10,
                              maxLines: 1,
                              obscureText: false,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                labelText: 'ユーザー名',
                              ),
                              onChanged: (text) {
                                userData.name = text;
                              }),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: size.width * 0.01,
                          right: size.width * 0.1,
                          left: size.width * 0.1),
                      child: FocusScope(
                          child: Focus(
                              onFocusChange: (focus) => controller.animateTo(
                                    size.height * 0.3,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  ),
                              child: Center(
                                child: TextField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9a-zA-Z@_.-]+$')),
                                    ],
                                    maxLength: 10,
                                    maxLines: 1,
                                    obscureText: false,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: const BorderSide(
                                            color: Colors.green, width: 1.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.green,
                                        ),
                                      ),
                                      labelText: 'クラスID',
                                    ),
                                    onChanged: (text) {
                                      userData.classCode = text;
                                    }),
                              )))),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.10, bottom: size.height * 0.40),
                    child: Center(
                      child: Container(
                        width: 200.0,
                        height: 50.0,
                        child: OutlinedButton(
                          child: const Text('スタート',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            shape: const StadiumBorder(),
                            side: const BorderSide(color: Colors.green),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/grade', arguments: userData);
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            )));
  }
}
