import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 150, left: 72, right:72),
        child: Center(
          child: Column(
            children: [
              Text('胸骨圧迫',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold)
              ),
              Padding(
                padding: EdgeInsets.only(top: 250),
                child: Center(
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ユーザー名',
                    ),
                  ),
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
                  ),
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
                      onPressed: () {Navigator.of(context).pushNamed('/select');},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}