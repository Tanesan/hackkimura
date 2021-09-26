import 'package:flutter/material.dart';
import 'package:hackkimura/model/BarometerArgs.dart';

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
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('採点モード'),
          // 右側のアイコン一覧
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text("2Lペットボトルの上にスマホを固定し，測定開始ボタンを押してください。"),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 250),
                  child: Container(
                      width: 300.0,
                      height: 300.0,
                      child: OutlinedButton(
                        child: Text('測定開始', style: TextStyle(fontSize: 64)),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: Colors.green),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/barometer',
                              arguments: BarometerArgs(mode: "battle"));
                        },
                      )),
                ),
              )
            ],
          ),
        )));
  }
}
