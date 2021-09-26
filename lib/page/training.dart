import 'package:flutter/material.dart';
import 'package:hackkimura/model/BarometerArgs.dart';
import 'package:hackkimura/model/UserData.dart';

class Training extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = ModalRoute.of(context)?.settings.arguments as UserData;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('トレーニングモード'),
        // 右側のアイコン一覧
        /*
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
           */
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text("2Lペットボトルの上にスマホを固定し，測定開始ボタンを押してください。",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 130),
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    child: OutlinedButton(
                      child: const Text('測定開始',
                          style: TextStyle(color: Colors.white, fontSize: 64)),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        shape: const StadiumBorder(),
                        side:
                            const BorderSide(color: Colors.green, width: 10.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/barometer',
                            arguments: BarometerArgs(
                                userData: userData, mode: "training"));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
