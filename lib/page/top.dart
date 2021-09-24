import 'package:flutter/material.dart';
import 'package:hackkimura/model/UserData.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 150, left: 72, right: 72),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text('胸骨圧迫',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Center(
                        child: TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ユーザー名',
                            ),
                            onChanged: (text) {
                              userData.name = text;
                            }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'パスワード',
                          ),
                          onChanged: (text) {
                            userData.classCode = text;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Container(
                          width: 300.0,
                          height: 50.0,
                          child: OutlinedButton(
                            child: const Text('スタート'),
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              shape: const StadiumBorder(),
                              side: const BorderSide(color: Colors.green),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/select', arguments: userData);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
