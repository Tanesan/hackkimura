import 'package:flutter/material.dart';
import 'package:hackkimura/model/UserData.dart';

class Training extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var userData = ModalRoute.of(context)?.settings.arguments as UserData;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
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
                      onPressed: () {Navigator.of(context).pushNamed('/barometer', arguments: userData);},
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