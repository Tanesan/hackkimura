import 'package:flutter/material.dart';

class Training extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text('トレーニングモード'),
          // 右側のアイコン一覧
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      body:   Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text("測定開始ボタンを押してから，ジップロックの袋の中にスマホを入れてください。およそ1分間胸骨圧迫をしてから，スマホを取り出して測定ボタンを押してください。音声でガイドするので音量を大きくしてください")
            ,
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    child: OutlinedButton(
                      child: const Text('測定開始'),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.green),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),],
          ),
        ),
      ),
    );
  }
}