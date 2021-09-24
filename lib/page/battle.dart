import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hackkimura/page/barometer.dart';
import 'dart:io';

class Battle extends StatefulWidget {
  const Battle({Key? key}) : super(key: key);

  @override
  _BattleState createState() => _BattleState();
}
class _BattleState extends State<Battle> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
          title: Text('バトルモード'),
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
              Text("測定開始ボタンを押してから，ジップロックの袋の中にスマホを入れてください。およそ1分間胸骨圧迫をしてから，スマホを取り出して測定ボタンを押してください。")
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
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                        sleep(Duration(seconds: 10));
                        // countDownCounter
                        return Barometer();
                      })),
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