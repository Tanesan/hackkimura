import 'package:flutter/material.dart';

class Grade extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text('マイページ'),
          // 右側のアイコン一覧
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      body:  Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text("バッジ一覧")
        ],
          ),
        ),
    );
  }
}