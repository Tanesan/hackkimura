import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
        title: Text('胸骨圧迫'),
        // 右側のアイコン一覧
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body:   Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 250),
              child: Center(
                child: Container(
                  width: 300.0,
                  height: 50.0,
                  child: OutlinedButton(
                    child: const Text('トレーニングモード'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () {Navigator.of(context).pushNamed('/training');},
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
                    child: const Text('バトルモード'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () {Navigator.of(context).pushNamed('/battle');},
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
                    child: const Text('マイページ'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () {Navigator.of(context).pushNamed('/');},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}